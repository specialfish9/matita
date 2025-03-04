(* TODO: Forse baseuri e' gia' in status *)
let rec eval_from_dedukti_stream ~asserted ~baseuri status buf =
  try
    let entry = Parsers.Parser.read buf in
    Parsers.Entry.pp_entry Format.err_formatter entry;
    let objs = ObjectConstruction.obj_of_entry status ~baseuri buf entry in
    let check_and_add ((uri, _, _, _, _) as obj) =
      HLog.message ("Tradotto!" ^ status#ppobj obj);
      let status = NCicLibrary.add_obj status obj in
      let xxaliases = GrafiteDisambiguate.aliases_for_objs status [ uri ] in
      let mode = GrafiteAst.WithPreferences in
      (* MATITA 1.0: fixme *)
      let status = GrafiteEngine.eval_alias status (mode, xxaliases) in
      status
    in
    (* TODO per fixare gli alias guardare matitaengine.ml da righe circa 230 235 *)
    let status =
      Option.fold ~none:status
        ~some:(fun list ->
          List.fold_left (fun _ obj -> check_and_add obj) status list)
        objs
    in

    eval_from_dedukti_stream ~asserted ~baseuri status buf
  with End_of_file -> (asserted, status)
