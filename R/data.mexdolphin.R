#' @name mexdolphin
#' @title Pan-tropical spotted dolphins in the Gulf of Mexico
#' @docType data
#' @description This a version of the `mexdolphins` dataset from the package `dsm`, reformatted
#' as point process data for use with `inlabru`. The data are from a combination of several NOAA
#' shipboard surveys conducted on pan-tropical spotted dolphins in the Gulf of Mexico. 47 observations
#' of groups of dolphins wre detected. The group size was recorded, as well as the Beaufort sea state at
#' the time of the observation.
#'
#' @usage data(mexdolphin)
#'
#' @format A list of objects:
#'  \describe{
#'    \item{`points`:}{ A `SpatialPointsDataFrame` object containing the locations of
#'    detected dolphin groups, with their size as an attribute.}
#'    \item{`samplers`:}{ A `SpatialLinesDataFrame` object containing the transect lines
#'    that were surveyed.}
#'    \item{`mesh`:}{ An `inla.mesh` object containing a Delaunay triangulation
#'    mesh (a type of discretization of continuous space) covering the survey region.}
#'    \item{`ppoly`:}{ An `SpatialPolygonsDataFrame` object defining the boundary of the
#'    survey region.}
#'    \item{`simulated`:}{ A `SpatialPointsDataFrame` object containing the locations of a
#'    *simulated* population of dolphin groups. The population was simulated from a 'code{inlabru}
#'    model fitted to the actual survey data. Note that the simulated data do not have any associated
#'    size information.}
#'  }
#' @source
#' Library `dsm`.
#'
#' @references
#' Halpin, P.N., A.J. Read, E. Fujioka, B.D. Best, B. Donnelly, L.J. Hazen, C. Kot, K. Urian,
#' E. LaBrecque, A. Dimatteo, J. Cleary, C. Good, L.B. Crowder, and K.D. Hyrenbach. 2009.
#' OBIS-SEAMAP: The world data center for marine mammal, sea bird, and sea turtle distributions.
#' Oceanography 22(2):104-115
#'
#' NOAA Southeast Fisheries Science Center. 1996. Report of a Cetacean Survey of Oceanic and
#' Selected Continental Shelf Waters of the Northern Gulf of Mexico aboard NOAA Ship Oregon II
#' (Cruise 220)
#'
#' @examples
#' \donttest{
#' data(mexdolphin, package = "inlabru")
#' ggplot() +
#'   gg(mexdolphin$mesh) +
#'   gg(mexdolphin$ppoly, color = "blue") +
#'   gg(mexdolphin$samplers) +
#'   gg(mexdolphin$points, aes(size = size), color = "red") +
#'   coord_equal()
#' }
NULL

#' Mexdolphin data import
#'
#'
#' Load `mexdolphins` survey data from `dsm` package and convert to spatial formats defined by the [sp] package.
#'
#' @aliases import.mexdolphin
#' @keywords internal
#' @return The [mexdolphin] data set
#' @examples
#' \dontrun{
#' mexdolphin <- import.mexdolphin()
#' }
#' @author Fabian E. Bachl \email{bachlfab@@gmail.com}
#'


import.mexdolphin <- function() {

  # library(dsm)
  data("mexdolphins", package = "dsm", envir = environment())
  data.p4s <- "+proj=lcc +lat_1=20 +lat_2=60 +lat_0=40 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

  stop("import.mexdolphin is broken. Reason: as.spatial.dsdata() removed from inlabru.")

  # dset = import.dsmdata(mexdolphins, covar.col = 8)
  # mexdolphin = as.spatial.dsdata(dset, cnames = c("x","y"), crs = CRS(data.p4s))
  #
  # # Target CRS
  # target.p4s = "+proj=lcc +lat_1=20 +lat_2=60 +lat_0=40 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=km +no_defs +towgs84=0,0,0"
  #
  # # Units to km
  # mexdolphin$points = spTransform(mexdolphin$points, CRSobj = CRS(target.p4s))
  # mexdolphin$samplers = spTransform(mexdolphin$samplers, CRSobj = CRS(target.p4s))
  # mexdolphin$points$distance = mexdolphin$points$distance / 1000
  # mexdolphin$mesh$loc = mexdolphin$mesh$loc/1000
  #
  # # Set mesh crs
  # mexdolphin$mesh$crs = inla.CRS(target.p4s)
  #
  # # Coordnames is set to NULL by spTransofrm ??
  # coordnames(mexdolphin$samplers) = c("x","y")
  #
  # # Set weights (transect width)
  # mexdolphin$samplers$weight = 16
  #
  # ##### Prediction polygon
  # polyloc = as.data.frame(mexdolphin$mesh$loc[mexdolphin$mesh$segm$int$idx,c(1,2)])
  # colnames(polyloc) = c("x","y")
  # po = Polygon(polyloc, hole=FALSE)
  # pos = Polygons(list(po), ID = "c")
  # predpoly = SpatialPolygons(list(pos))
  # df = data.frame(weight = 1)
  # rownames(df) = "c"
  # predpolyd = SpatialPolygonsDataFrame(predpoly, data = df)
  # # plot(predpolyd)
  # mexdolphin$ppoly = predpolyd
  # proj4string(mexdolphin$ppoly) = proj4string(mexdolphin$points)
  #
  # ##### Simulate a whole population #####
  # distance = seq(0, 8, length.out = 20)
  # fml = coordinates + distance ~ df.lsigma + g(spat, model = inla.spde2.matern(mexdolphin$mesh), mesh = mexdolphin$mesh)
  # pred = expression(log(1-exp(-(distance/(exp(df.lsigma)))^-1)) + spat + Intercept)
  # r = lgcp(points = mexdolphin$points, samplers = mexdolphin$samplers, model = fml, predictor = pred, mesh = mexdolphin$mesh)
  # llambda = log(8) + r$summary.random$spat$mean + r$summary.fixed["Intercept","mean"]
  # # sum( exp(llambda) * diag(inla.mesh.fem(mexdolphin$mesh)$c0))
  # smexdolphin = mexdolphin
  # smexdolphin$llambda = llambda
  # pts = data.frame(sample.lgcp(mexdolphin$mesh, llambda))
  #
  # ### remove samples outside prediction polygon. The sp package over() method somehow does not work.
  # loc = mexdolphin$ppoly@polygons[[1]]@Polygons[[1]]@coords
  # seg = inla.mesh.segment(loc[rev(1:nrow(loc)),])
  # msh = inla.mesh.2d(boundary=seg, max.edge = 100)
  # # plot(msh)
  # # points(pts, col = 1+is.inside(msh, coordinates(pts)))
  # pts = pts[is.inside(msh, coordinates(pts)),]
  # coordinates(pts) = c("x","y")
  # proj4string(pts) = proj4string(mexdolphin$points)
  # mexdolphin$simulated = SpatialPointsDataFrame(pts, data.frame(size = rep(1, length(pts))))
  # mexdolphin$lambda = exp(llambda)
  #
  # #### Depth covariate #####
  # depth = mexdolphins$preddata[,c("x","y","depth")]
  # coordinates(depth) = c("x","y")
  # proj4string(depth) = data.p4s
  # # gg.map(depth) + gg.point(depth, CRS("+proj=longlat")) +
  # # gg.polygon(mexdolphin$ppoly, CRS("+proj=longlat"))
  # mexdolphin$depth = spTransform(depth, CRS(target.p4s))
  #
  #
  # mexdolphin$samplers$distance = NULL
  #
  # # return
  # mexdolphin
}


save.mexdolphin <- function() {
  mexdolphin <- import.mexdolphin()
  save("mexdolphin", file = paste0(system.file("data", package = "inlabru"), "/mexdolphin.RData"))
}
