use_cheatsheet_logo <- function(pkg, geometry = "240x278", alt = "", retina = TRUE) {
  tf <- withr::local_tempfile(fileext = ".png")

  gh::gh(
    "/repos/rstudio/hex-stickers/contents/PNG/{pkg}.png/",
    pkg = pkg,
    .destfile = tf,
    .accept = "application/vnd.github.v3.raw"
  )

  logo_path <- fs::path("images", glue::glue("logo-{pkg}.png"))

  fs::dir_create("images", recurse = TRUE)

  img_data <- magick::image_read(tf)
  img_data <- magick::image_resize(img_data, geometry)
  magick::image_write(img_data, logo_path)
  height <- magick::image_info(magick::image_read(logo_path))$height

  if (retina) {
    height <- round(height / 2)
  }

  cat(glue::glue(
    '
    <img src="images/logo-{pkg}.png" height="{height}" alt="{alt}" />
    <br><br>
    '
  ))
}

pdf_preview_link <- function(sheet_name) {
  cat(glue::glue(
    '
    <a href="../{sheet_name}.pdf">
    <p><i class="bi bi-file-pdf"></i> Download PDF</p>
    <img src="../pngs/{sheet_name}.png" width="200" alt=""/>
    </a>
    <br><br>
    '
  ))
}

translation_list <- function(sheet_name) {
  f <- fs::dir_ls(
    "../translations",
    regex = glue::glue("{sheet_name}.+\\.pdf"),
    recurse = 1, # old versions are in subfolders
    )

  if (length(f) == 0)
    return(invisible())

  lang <- tools::toTitleCase(vapply(fs::path_split(f), `[[`, 3, FUN.VALUE = character(1)))

  cat(
    '<p>Translations (PDF)</p>',
    glue::glue('* <a href="{f}"><i class="bi bi-file-pdf"></i>{lang}</a>'), 
    sep = "\n")
}

