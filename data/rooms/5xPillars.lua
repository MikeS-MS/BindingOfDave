return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 48,
  height = 27,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 9,
  nextobjectid = 26,
  properties = {},
  tilesets = {
    {
      name = "TX Tileset Stone Ground",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../TileSets/TX Tileset Stone Ground.png",
      imagewidth = 256,
      imageheight = 256,
      transparentcolor = "#ff00ff",
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 64,
      tiles = {}
    },
    {
      name = "TX Tileset Wall",
      firstgid = 65,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../TileSets/TX Tileset Wall.png",
      imagewidth = 512,
      imageheight = 512,
      transparentcolor = "#ff00ff",
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 256,
      tiles = {}
    },
    {
      name = "TX Tileset Grass",
      firstgid = 321,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../TileSets/TX Tileset Grass.png",
      imagewidth = 256,
      imageheight = 256,
      transparentcolor = "#ff00ff",
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 64,
      tiles = {}
    },
    {
      name = "DefaultStyle",
      firstgid = 385,
      tilewidth = 30,
      tileheight = 30,
      spacing = 0,
      margin = 0,
      columns = 10,
      image = "../TileSets/DefaultStyle.png",
      imagewidth = 300,
      imageheight = 300,
      transparentcolor = "#ff00ff",
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 30,
        height = 30
      },
      properties = {},
      wangsets = {},
      tilecount = 100,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 27,
      id = 7,
      name = "Background",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0,
        0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 0,
        0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0,
        0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 0,
        0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 27,
      id = 1,
      name = "Ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        10, 10, 41, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 2147483689, 2147483658, 2147483658,
        10, 10, 11, 114, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 116, 2147483659, 2147483658, 2147483658,
        41, 18, 19, 130, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 131, 132, 2147483667, 2147483666, 2147483689,
        11, 536871026, 536871042, 372, 353, 368, 324, 326, 346, 363, 341, 380, 342, 331, 344, 371, 371, 364, 363, 337, 350, 356, 336, 378, 347, 351, 377, 374, 378, 355, 371, 382, 355, 358, 376, 334, 366, 330, 321, 372, 360, 382, 380, 379, 350, 2684354690, 2684354674, 2147483659,
        11, 536871027, 536871043, 341, 358, 330, 338, 381, 352, 350, 356, 378, 365, 355, 322, 338, 370, 338, 346, 341, 333, 346, 342, 342, 363, 366, 375, 377, 373, 349, 331, 348, 382, 337, 365, 343, 342, 344, 336, 331, 325, 369, 355, 382, 379, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 331, 353, 369, 364, 348, 333, 368, 363, 340, 330, 322, 345, 345, 334, 380, 343, 338, 365, 330, 353, 371, 377, 379, 329, 374, 340, 331, 333, 363, 372, 378, 361, 337, 370, 378, 381, 344, 380, 360, 337, 358, 358, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 373, 372, 323, 321, 364, 342, 365, 327, 355, 352, 343, 340, 362, 333, 338, 360, 379, 336, 380, 360, 333, 324, 364, 373, 343, 345, 330, 372, 325, 362, 344, 373, 338, 336, 323, 356, 339, 365, 361, 369, 344, 363, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 369, 331, 329, 371, 333, 360, 378, 323, 356, 338, 364, 372, 352, 374, 382, 345, 336, 331, 322, 342, 367, 380, 349, 353, 344, 330, 369, 357, 382, 352, 340, 333, 338, 372, 327, 357, 382, 341, 327, 326, 373, 363, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 328, 372, 337, 355, 344, 337, 371, 376, 363, 375, 352, 371, 382, 381, 332, 336, 359, 335, 369, 379, 364, 355, 382, 361, 349, 368, 336, 366, 378, 355, 360, 323, 340, 346, 356, 355, 355, 353, 340, 357, 347, 354, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 361, 350, 368, 372, 331, 338, 353, 362, 345, 373, 361, 347, 381, 338, 322, 377, 329, 357, 344, 362, 338, 349, 372, 370, 376, 324, 362, 324, 329, 376, 370, 336, 337, 357, 332, 321, 378, 346, 361, 345, 373, 321, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 330, 328, 343, 363, 372, 357, 376, 359, 358, 372, 367, 360, 339, 341, 365, 368, 353, 328, 380, 378, 325, 375, 324, 361, 333, 372, 323, 380, 344, 323, 327, 336, 364, 351, 382, 357, 359, 374, 339, 365, 360, 365, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 362, 353, 335, 340, 356, 367, 340, 329, 323, 356, 344, 330, 334, 378, 363, 357, 356, 364, 372, 337, 351, 378, 378, 362, 364, 379, 364, 352, 356, 337, 336, 373, 340, 359, 342, 337, 351, 359, 363, 377, 347, 355, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 335, 360, 333, 363, 367, 348, 328, 346, 378, 352, 362, 339, 352, 323, 337, 379, 338, 324, 380, 351, 346, 342, 333, 346, 361, 382, 379, 350, 377, 336, 353, 345, 354, 375, 328, 321, 339, 330, 373, 341, 327, 358, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 330, 343, 370, 366, 324, 370, 374, 342, 338, 327, 380, 324, 334, 366, 361, 368, 344, 344, 347, 374, 328, 376, 370, 362, 348, 358, 354, 367, 361, 331, 323, 358, 359, 347, 361, 351, 328, 375, 334, 327, 367, 345, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 360, 353, 380, 355, 369, 342, 338, 345, 380, 349, 332, 348, 381, 338, 373, 379, 356, 363, 371, 375, 379, 365, 325, 333, 341, 349, 325, 347, 377, 357, 343, 322, 329, 347, 353, 338, 361, 326, 339, 372, 331, 368, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 325, 378, 351, 328, 366, 346, 371, 381, 337, 331, 329, 354, 356, 339, 330, 370, 347, 343, 359, 360, 343, 338, 349, 378, 363, 380, 362, 363, 372, 368, 331, 328, 339, 371, 358, 322, 382, 354, 354, 329, 324, 380, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 331, 325, 380, 370, 380, 352, 331, 355, 329, 329, 365, 365, 365, 338, 335, 324, 328, 334, 348, 321, 354, 337, 350, 339, 355, 373, 347, 347, 360, 375, 359, 344, 322, 333, 363, 355, 376, 354, 322, 343, 361, 372, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 343, 339, 370, 334, 324, 341, 366, 324, 327, 339, 330, 377, 376, 347, 324, 360, 365, 362, 372, 345, 329, 360, 366, 328, 344, 376, 371, 371, 372, 347, 376, 350, 336, 325, 358, 350, 369, 351, 321, 345, 327, 373, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 370, 342, 332, 352, 378, 327, 347, 360, 367, 335, 367, 366, 368, 360, 321, 367, 377, 381, 353, 367, 338, 352, 381, 364, 373, 327, 373, 368, 361, 362, 324, 344, 355, 363, 350, 339, 376, 339, 336, 338, 337, 352, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 345, 343, 349, 330, 326, 340, 380, 381, 335, 335, 326, 382, 321, 357, 324, 337, 372, 321, 334, 344, 338, 373, 325, 349, 351, 361, 347, 327, 357, 341, 354, 376, 327, 325, 370, 345, 358, 322, 345, 340, 325, 371, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 333, 323, 347, 360, 352, 325, 372, 324, 327, 354, 362, 366, 362, 341, 374, 324, 359, 373, 357, 370, 378, 330, 365, 338, 337, 333, 322, 370, 351, 365, 360, 337, 344, 364, 364, 328, 352, 370, 339, 378, 350, 342, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 337, 358, 363, 369, 379, 375, 342, 380, 348, 376, 376, 341, 346, 361, 323, 373, 340, 336, 342, 349, 360, 334, 365, 366, 366, 366, 322, 340, 354, 342, 376, 325, 333, 337, 379, 332, 325, 381, 380, 354, 353, 328, 2684354691, 2684354675, 2147483659,
        11, 536871027, 536871043, 359, 356, 373, 359, 330, 356, 373, 354, 368, 341, 326, 365, 343, 365, 378, 349, 323, 345, 370, 355, 370, 361, 374, 358, 361, 359, 338, 325, 381, 378, 356, 339, 360, 370, 351, 369, 349, 335, 322, 361, 360, 371, 2684354691, 2684354675, 2147483659,
        11, 536871028, 536871044, 322, 340, 343, 368, 371, 360, 365, 342, 361, 357, 372, 347, 376, 333, 376, 355, 357, 349, 350, 348, 360, 323, 353, 368, 324, 341, 375, 354, 327, 379, 322, 371, 370, 347, 344, 338, 364, 350, 382, 331, 343, 339, 2684354692, 2684354676, 2147483659,
        1073741865, 1073741842, 1073741843, 1073741954, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741955, 1073741956, 3221225491, 3221225490, 3221225513,
        10, 10, 11, 1073741938, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741939, 1073741940, 2147483659, 2147483658, 2147483658,
        10, 10, 1073741865, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 1073741842, 3221225513, 2147483658, 2147483658
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 27,
      id = 6,
      name = "Tops",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 10, 10, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 27,
      id = 5,
      name = "Pillars",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 83, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 83, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 99, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 99, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 131, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 131, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 83, 83, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 115, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 131, 131, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 83, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 83, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 99, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 99, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 131, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 131, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Collisions",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "Left",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 96,
          height = 864,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "Top",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 0,
          width = 1344,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Right",
          type = "",
          shape = "rectangle",
          x = 1440,
          y = 0,
          width = 96,
          height = 864,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "Bottom",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 768,
          width = 1344,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "Pillar",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 224,
          width = 96,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "Pillar",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 224,
          width = 96,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "Pillar",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 512,
          width = 96,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "Pillar",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 512,
          width = 96,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "Pillar",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 353,
          width = 128,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "SpawnLocations",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 8,
          name = "PlayerSpawnLocation",
          type = "",
          shape = "rectangle",
          x = 767.5,
          y = 149.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "player"
          }
        },
        {
          id = 15,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 1350.67,
          y = 161.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        },
        {
          id = 16,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 1348,
          y = 701.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        },
        {
          id = 17,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 177.333,
          y = 704,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        },
        {
          id = 18,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 185.333,
          y = 161.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        },
        {
          id = 19,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 556,
          y = 425.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        },
        {
          id = 20,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 764,
          y = 612,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        },
        {
          id = 21,
          name = "EnemySpawnLocation",
          type = "",
          shape = "rectangle",
          x = 970.667,
          y = 428,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "enemy"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "DoorLocations",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 22,
          name = "DoorSpawnLocation",
          type = "",
          shape = "rectangle",
          x = 1472,
          y = 432,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["side"] = "right"
          }
        },
        {
          id = 23,
          name = "DoorSpawnLocation",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 432,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["side"] = "left"
          }
        },
        {
          id = 24,
          name = "DoorSpawnLocation",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["side"] = "top"
          }
        },
        {
          id = 25,
          name = "DoorSpawnLocation",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 800,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["side"] = "bottom"
          }
        }
      }
    }
  }
}
