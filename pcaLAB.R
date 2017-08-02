pcaLAB <- function(lab) {
    evec <- stats::prcomp(lab)$rotation
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
    
    return(do.call(rbind, res))
}

input <- RGB(runif(100), runif(100), runif(100))
foo <- pcaLAB(coords(as(input, 'LAB')))

plot(input)
plot(LAB(foo[, -(1:3)]))
