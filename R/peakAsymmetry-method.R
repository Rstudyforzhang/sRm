#' @rdname peakAsymmetry
#'

setMethod('peakAsymmetry', signature = 'SRM',
          function(object) {
            peakChromAsym <- list()

            for (i in 1:nrow(object@peaks)) {
              print(i)
              rawChrom <-
                object@rawChrom %>% dplyr::filter(
                  sampleID == object@peaks$sampleID[i] &
                    index == object@peaks$index[i] &
                    rt >= object@peaks$rtmin[i] &
                    rt <= object@peaks$rtmax[i]
                )


              rtmax <-
                rawChrom$rt[rawChrom$int == max(rawChrom$int)]

              peak_front_10 <-
                rawChrom$rt[rawChrom$rt < rtmax][which.min(abs(rawChrom$int[rawChrom$rt < rtmax] - max(rawChrom$int) * 0.1))]


              peak_tail_10 <-
                rawChrom$rt[rawChrom$rt > rtmax][which.min(abs(rawChrom$int[rawChrom$rt > rtmax] - max(rawChrom$int) * 0.1))]

              A10 <- rtmax - peak_front_10
              B10 <- peak_tail_10 - rtmax

              Asym <- B10 / A10

              peakChromAsym[[i]] <-
                object@peaks[i, ] %>% dplyr::mutate(PeakAsymm = Asym)
            }

            object@peaks <- peakChromAsym %>% dplyr::bind_rows()


          })
