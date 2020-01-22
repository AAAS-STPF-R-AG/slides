library(sf)
library(tmap)

dc_wards <- st_read("https://opendata.arcgis.com/datasets/0ef47379cbae44e88267c01eaec2ff6e_31.geojson")
dc_wards <- read_sf("https://opendata.arcgis.com/datasets/0ef47379cbae44e88267c01eaec2ff6e_31.geojson")

dc_wards

bikeshare_locations <- read_sf("2020-01-21/data/bikeshare_locations.shp")
head(bikeshare_locations)

plot(st_geometry(dc_wards))
plot(st_geometry(bikeshare_locations), add = T, col = "red")

dc_wards$geometry

dc_wards <- st_transform(dc_wards, 6654)
bikeshare_locations <- st_transform(bikeshare_locations, 6654)

plot(st_geometry(dc_wards))
plot(st_geometry(bikeshare_locations), add = T, col = "red")

qtm(dc_wards)

tmap_mode("view")

tm_shape(dc_wards) +
  tm_polygons(col = "POP_2000") +
  tm_shape(bikeshare_locations) +
  tm_dots(size = 0.1) +
  tm_compass()

library(ggplot2)
ggplot(dc_wards) +
  geom_sf()

bikes_in_dc <- st_intersection(dc_wards, bikeshare_locations)

tm_shape(dc_wards) +
  tm_borders() +
  tm_shape(bikeshare_locations) +
  tm_dots(size = 0.1)

st_join(bikeshare_locations, dc_wards) %>% 
  dplyr::count(WARD)
