use_cheatsheet_logo <- function(pkg, geometry = "240x278", retina = TRUE) {
  tf <- withr::local_tempfile(fileext = ".png")

  gh::gh(
    "/repos/rstudio/hex-stickers/contents/PNG/{pkg}.png/",
    pkg = pkg,
    .destfile = tf,
    .accept = "application/vnd.github.v3.raw"
  )

  if (!requireNamespace("magick", quietly = TRUE)) {
    stop("Please install the magick package to use this function")
  }

  logo_path <- fs::path("images", "logo.png")

  fs::dir_create("images", recurse = TRUE)

  img_data <- magick::image_read(tf)
  img_data <- magick::image_resize(img_data, geometry)
  magick::image_write(img_data, logo_path)
  height <- magick::image_info(magick::image_read(logo_path))$height

  if (retina) {
    height <- round(height / 2)
  }

  cat(glue::glue(
    "<img src=\"images/logo.png\" align=\"right\" height=\"{height}\" alt=\"\" />"
  ))
}