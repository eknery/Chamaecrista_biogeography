
### mixing color function
mix_color <- function(col1, col2, prop = 0.5) {
  # convert to RGB
  rgb1 <- col2rgb(col1) / 255
  rgb2 <- col2rgb(col2) / 255
  # mix rgb
  mixed_col <- rgb(
    red   = (1 - prop) * rgb1["red", ] + prop * rgb2["red", ],
    green = (1 - prop) * rgb1["green", ] + prop * rgb2["green", ],
    blue  = (1 - prop) * rgb1["blue", ] + prop * rgb2["blue", ]
  )
  return(mixed_col)
}

