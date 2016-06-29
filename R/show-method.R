#' show-sRm
#' @rdname show
#'

setMethod("show", signature = "SRM",
          function(object){
            cat("file id", object@meta$fileID, sep = " : ")
            cat("\n", "\n")
            cat("run time : ", round(max(object@totalIonCount$rt), digits = 2), "mins")
            cat("\n", "\n")
            cat(nrow(object@header), "SRM transitions measured", sep = " ")
            cat("\n", "\n")
            cat(length(unique(object@header$parentMz)), "unique parent masses", sep = " ")
            cat("\n", "\n")
            cat(length(unique(object@header$Q3mz)), "unique Q3 product ions", sep = " ")
          }
)