# Matrix entropy visualisation

R version of this python implementation of *Measuring entropy patterns of a 2d binary matrix* by William Huber using Mathematica at https://github.com/MarkEdmondson1234/matrix-entropy

It uses the concept of localised similarilty to try and give an intuitive visualisation on if a matrix is ordered (low entropy) or unordered (high entropy)

## Demo

k is the localarity level (size of grid that sums squares), S the measure of entropy, from Inf to 0.  Comparing random and ordered grids of the same size, S should be lower for more ordered boards at the interesting level of granularity.  For very small `k=1` its the same as the original matrix, for very large `k=N` everything averages out and no features are detected. 

## Outputs

A random 100 binary matrix has `2^10^2 = 1.267651e+30` possible states. 

![](random_100.png)

Chess board:

```r
chess <- matrix(rep(c(rep(c(1, 0), 4), rep(c(0,1), 4)), 4), nrow = 8)


plot_ks(chess)
         1          2          3          4          5          6          7          8 
       Inf 275.120782 186.439894 116.096405  64.018481  28.529325   8.001202   0.000000 
```

![](chess.png)

Random board:

```r
my_matrix <- test_matrix(8)
plot_ks(my_matrix)

         1          2          3          4          5          6          7          8 
       Inf        Inf 188.909173 116.743077  64.146206  28.551523   8.007139   0.000000 
```

![](random_8.png)

```r
m_lowest <- low_matrix(8)
plot_ks(m_lowest)
1 2 3 4 5 6 7 8 
0 0 0 0 0 0 0 0 
```

