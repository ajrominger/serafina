pcaLAB <- function(lab) {
    evec <- stats::prcomp(lab)$rotation #+ colMeans(lab)
    centroid <- colMeans(lab)
    
    res <- lapply(1:nrow(lab), function(i) {
        out <- sapply(1:ncol(evec), function(j) {
            projScalar <- lab[i, ] %*% evec[, j] / (evec[, j] %*% evec[, j])
            projVec <- lab[i, ] - projScalar * evec[, j]
            projDist <- projVec %*% projVec
            
            return(c(cp = projScalar, err = projDist))
        })
        
        v <- which.min(out[2, ])
        
        return(c(v = v, out[, v], out[1, v] * evec[, v]))
    })
    
    return(list(centroid = centroid, evec = evec, matching = do.call(rbind, res)))
}

gradientFromPCA <- function(pca, i, n) {
    d <- seq(0, 10, length.out = n)
    # LAB(t(pca$centroid + outer(pca$evec[, i], d)))
    LAB(t(outer(pca$evec[, i], d)))
}


foo <- jpeg::readJPEG('IMG_1124.JPG', native = FALSE)
foo <- array(as.vector(foo), dim = c(prod(dim(foo)[1:2]), 3))
foo <- foo[sample(nrow(foo), 1000), ]
foo <- as(RGB(foo), 'LAB')

par(mar = rep(0, 4))
r <- persp(c(-100, 100), c(-100, 100), matrix(c(0, 100, 100, 0), nrow = 2), 
           xlab = '', ylab = '', zlab = '', col = NA, border = NA, 
           theta = 30, phi = 10)

points(trans3d(coords(foo)[, 2], coords(foo)[, 3], coords(foo)[, 1], r), 
       pch = 16, cex = 1, col = rgb(coords(as(foo, 'RGB'))))


bla <- pcaLAB(coords(foo))

plot(LAB(bla[[3]][, -(1:3)]))

plot(gradientFromPCA(bla, 1, 20))
plot(gradientFromPCA(bla, 2, 10))
plot(gradientFromPCA(bla, 3, 10))

