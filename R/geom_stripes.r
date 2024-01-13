#' @export
#' @import dplyr
geom_stripes_horizontal <- function(mapping = NULL,
                         data = NULL,
                         stat = "identity",
                         position = "identity",
                         ...,
                         show.legend = NA,
                         inherit.aes = TRUE) {
    # if (is.null(along)) {
    #   cli::cli_abort("{.fn geom_stripes} requires {.emph along} to be set.")
    # }                                    
    # if (!is.null(along) && !along %in% c("x", "y")) {
    #   cli::cli_abort("{.fn geom_stripes} requires {.emph along} to be either equal to \"x\" or \"y\".")
    # }        
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomStripesX,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
        ...
    )
  )
}

#' @export
geom_stripes_vertical <- function(mapping = NULL,
                         data = NULL,
                         stat = "identity",
                         position = "identity",
                         ...,
                         show.legend = NA,
                         inherit.aes = TRUE) {
    # if (is.null(along)) {
    #   cli::cli_abort("{.fn geom_stripes} requires {.emph along} to be set.")
    # }                                    
    # if (!is.null(along) && !along %in% c("x", "y")) {
    #   cli::cli_abort("{.fn geom_stripes} requires {.emph along} to be either equal to \"x\" or \"y\".")
    # }        
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomStripesY,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
        ...
    )
  )
}

GeomStripes <- ggplot2::ggproto("GeomStripes", ggplot2::Geom,
    required_aes = c("y"),
    default_aes = ggplot2::aes(
        xmin = -Inf, xmax = Inf,
        ymin = -Inf, ymax = Inf,
        odd = "#22222222", even = "#00000000",
        # Change 'size' below from 0 to NA.
        # When not NA then when *printing in pdf device* borders are there despite
        # requested 0th size. Seems to be some ggplot2 bug caused by grid overriding
        # an lwd parameter somewhere, unless the size is set to NA. Found solution here
        # https://stackoverflow.com/questions/43417514/getting-rid-of-border-in-pdf-output-for-geom-label-for-ggplot2-in-r
        alpha = NA, colour = "black", linetype = "solid", size = NA
    ),
    draw_key = ggplot2::draw_key_rect
)

GeomStripesX <- ggplot2::ggproto("GeomStripesX", GeomStripes,
  draw_panel = function(data, panel_params, coord) {
    browser()
    ggplot2::GeomRect$draw_panel(
      # in case we have facets, not every row/column of every sample will necessarily be present
      # I resort to this hack for now, since I don't know how to access the parent data
      data %>%
          full_join(data.frame(
              y = attributes(panel_params$y.sec$breaks)$pos
          ), by = "y") %>%
          mutate(across(all_of(c("xmin", "xmax", "odd", "even", "alpha", "colour", "linetype", "size")), ~ .[!is.na(.)][1])) %>%
        dplyr::mutate(
          y = round(.data$y),
          ymin = .data$y - 0.5,
          ymax = .data$y + 0.5
        ) %>%
        dplyr::select(
          .data$xmin, .data$xmax,
          .data$ymin, .data$ymax,
          .data$odd, .data$even,
          .data$alpha, .data$colour, .data$linetype, .data$size
        ) %>%
        distinct() %>%
        dplyr::arrange(.data$ymin) %>%
        dplyr::mutate(
          .n = dplyr::row_number(),
          fill = dplyr::if_else(
            .data$.n %% 2L == 1L,
            true = .data$odd,
            false = .data$even
          )
        ) %>%
        dplyr::select(-.data$.n, -.data$odd, -.data$even),       
      panel_params,
      coord
    )
  }
)

GeomStripesY <- ggplot2::ggproto("GeomStripesY", GeomStripes,
  draw_panel = function(data, panel_params, coord) {
    browser()
    ggplot2::GeomRect$draw_panel(
      # in case we have facets, not every row/column of every sample will necessarily be present
      # I resort to this hack for now, since I don't know how to access the parent data
      data %>%
          full_join(data.frame(
              x = attributes(panel_params$x.sec$breaks)$pos
          ), by = "x") %>%
          mutate(across(all_of(c("ymin", "ymax", "odd", "even", "alpha", "colour", "linetype", "size")), ~ .[!is.na(.)][1])) %>%
              arrange(x) %>%
        dplyr::mutate(
          x = round(.data$x),
          xmin = .data$x - 0.5,
          xmax = .data$x + 0.5
        ) %>%
        dplyr::select(
          .data$xmin, .data$xmax,
          .data$ymin, .data$ymax,
          .data$odd, .data$even,
          .data$alpha, .data$colour, .data$linetype, .data$size
        ) %>%
        distinct() %>%
        dplyr::arrange(.data$ymin) %>%
        dplyr::mutate(
          .n = dplyr::row_number(),
          fill = dplyr::if_else(
            .data$.n %% 2L == 1L,
            true = .data$odd,
            false = .data$even
          )
        ) %>%
        dplyr::select(-.data$.n, -.data$odd, -.data$even),    
      panel_params,
      coord
    )
  }
)




