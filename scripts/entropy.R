library(purrr)

# A random 0 or 1 square matrix of dimensions n*m
test_matrix <- function(n, m = n){
  matrix(sample(0:1, size = n*m, replace = TRUE), nrow = n, ncol = m)
}

low_matrix <- function(n, x = 1){
  matrix(rep(x, n^2), nrow = n)
}

#' Sum the sub-matrix in my_matrix for sub-matrix of size k
#' @importFrom purrr
#' @return A matrix of sums, where each coordinate is sum of matrix size k in position in original matrix
f_subset <- function(my_matrix, k, f = sum){
  my_dim <- dim(my_matrix)
  k_n <- (k-1)
  along <- my_dim[1] - k_n
  down  <- my_dim[2] - k_n
  map(1:along, 
      ~ map_dbl(1:down, 
                function(y) f(my_matrix[.x:(.x+k_n), y:(y+k_n)])
                )
      ) %>% 
    unlist %>% matrix(ncol = along, byrow = TRUE) / k^2

}

all_ks <- function(my_matrix){
  my_dim <- dim(my_matrix)
  along <- 1:(min(my_dim))
  along <- setNames(along, along)
  map_dbl(along, ~ sum(log(f_subset(my_matrix, .)))*(-1))
}

plot_ks <- function(my_matrix){
  my_dim <- dim(my_matrix)

  along <- all_ks(my_matrix)
  
  par(mfrow = c(ceiling(sqrt(my_dim[1])), ceiling(sqrt(my_dim[2]))),
      mar = c(1.5,1.5,1.5,1.5))
  
  walk(names(along), 
       function(x){
         aa <- along[[x]]
         image(f_subset(my_matrix, as.numeric(x)),
                col = RColorBrewer::brewer.pal(3, "Oranges"))
         title(main = paste("k=",x, " S = ", round(aa, 2)))
         
       })
  
  along
}

my_matrix <- test_matrix(8)
mm <- matrix(c(1,0,0,0,1,0,0,1,0,0,0,1,0,1,1,1,0,0,0,0,0,1,0,1,1), nrow = 5, byrow = TRUE)
life <- matrix(c(0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0), nrow = 5, byrow = TRUE)
chess <- matrix(rep(c(rep(c(1, 0), 4), rep(c(0,1), 4)), 4), nrow = 8)
m_highest <- low_matrix(8)
m_lowest <- low_matrix(8, x = 0)

plot_ks(mm)
plot_ks(chess)
plot_ks(test_matrix(8))
plot_ks(life)
plot_ks(my_matrix)
plot_ks(m_lowest)
plot_ks(m_highest)

mm_big <- test_matrix(100)
m_big_lowest <- low_matrix(100)
plot_ks(mm_big)
plot_ks(m_big_lowest)
