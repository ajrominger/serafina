pcaLAB <- function(lab) {
    evecs <- prcomp(lab)$rotation
    browser()
    lapply(1:ncol(evecs), function(i) {
        sapply(1:nrow(lab), function(j) {
            projScalar <- as.numeric(lab[j, ] %*% evecs[, i])
            projVec <- lab[j, ] - projScalar * evecs[, i]
            projDist <- as.numeric(projVec %*% projVec)
            
            return(c(d = projScalar, se = sqrt(projDist)))
        })
    })
    r <- persp(range(lab[, 'A']), range(lab[, 'B']), matrix(1:4, 2), zlim = range(lab[, 'L']), 
          xlab = '', ylab = '', zlab = '', theta = 60, phi = 10, 
          col = NA, border = NA)
    points(trans3d(lab[, 'A'], lab[, 'B'], lab[, 'L'], r), col = test)
    d <- seq(-100, 100, length.out = 5)
    lines(trans3d(mean(lab[, 'A']) + d * evecs[1, 2], 
                  mean(lab[, 'B']) + d * evecs[2, 2], 
                  mean(lab[, 'L']) + d * evecs[3, 2], 
                  r))
}


test <- hsv(c(0.18, 0.15, 0.1, 0, 0.03, 0.8, 0.75, 0.7), 
            c(0.80, 0.95, 0.9, 1, 0.75, 0.8, 0.70, 0.8), 
            c(1.00, 0.95, 0.9, 1, 0.65, 0.5, 0.80, 0.8))

pcaLAB(as(colorspace::RGB(t(col2rgb(test)) / 255), 'LAB')@coords)
