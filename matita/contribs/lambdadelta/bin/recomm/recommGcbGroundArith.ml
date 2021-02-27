module T = RecommTypes
module R = RecommPcsAnd

let step k st outs ins =
  if st <> T.OO then k st outs ins else
  match ins with
  | "ylt" :: tl -> k T.OK ("ylt" :: outs) tl
  | "yle" :: tl -> k T.OK ("yle" :: outs) tl
  | "ylminus" :: tl -> k T.OK ("ylminus" :: outs) tl
  | "yminus" :: tl -> k T.OK ("ylminus" :: outs) tl
  | "yplus" :: tl -> k T.OK ("yplus" :: outs) tl
  | "ypred" :: tl -> k T.OK ("ypred" :: outs) tl
  | "ysucc" :: tl -> k T.OK ("ysucc" :: outs) tl
  | "nlt" :: tl -> k T.OK ("nlt" :: outs) tl
  | "nle" :: tl -> k T.OK ("nle" :: outs) tl
  | "nmax" :: tl -> k T.OK ("nmax" :: outs) tl
  | "nminus" :: tl -> k T.OK ("nminus" :: outs) tl
  | "nplus" :: tl -> k T.OK ("nplus" :: outs) tl
  | "npred" :: tl -> k T.OK ("npred" :: outs) tl
  | "nsucc" :: tl -> k T.OK ("nsucc" :: outs) tl
  | "ntri" :: tl -> k T.OK ("ntri" :: outs) tl
  | "niter" :: tl -> k T.OK ("niter" :: outs) tl
  | _ -> k T.OO outs ins

let main =
  R.register_b step
