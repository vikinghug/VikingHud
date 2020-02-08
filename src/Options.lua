local LSM = LibStub("LibSharedMedia-3.0")

local addonName, addon = ...

local AceConfig = LibStub("AceConfig-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

local Options = {}; addon.Options = Options

local function spairs(t, order)
  -- collect the keys
  local keys = {}
  for k in pairs(t) do keys[#keys+1] = k end

  -- if order function given, sort by it by passing the table and keys a, b,
  -- otherwise just sort the keys
  if order then
      table.sort(keys, function(a,b) return order(t, a, b) end)
  else
      table.sort(keys)
  end

  -- return the iterator function
  local i = 0
  return function()
      i = i + 1
      if keys[i] then
          return keys[i], t[keys[i]]
      end
  end
end

Options.primary = {
  name = addonName,
  type = 'group',
  args = {

    blah = {
      name = "Bar Size and position",
      type = "header",
      order = 1
    },

    positionX = {
  		name = 'Horizontal Postition',
  		type = 'range',
      order = 2,
      softMin = -400,
      softMax = 400,
  		-- desc = '',
      set = function(info, val)
        addon.Settings.db.profile.positionX = val
        addon:UpdatePosition()
      end,
  		get = function(info) return addon.Settings.db.profile.positionX end,
    },

    positionY = {
  		name = 'Vertical Postition',
  		type = 'range',
      order = 3,
      softMin = -400,
      softMax = 400,
  		-- desc = '',
      set = function(info, val)
        addon.Settings.db.profile.positionY = val
        addon:UpdatePosition()
      end,
  		get = function(info) return addon.Settings.db.profile.positionY end,
    },


    targetNameY = {
  		name = 'Target Text Vertical Postition',
  		type = 'range',
      order = 3,
      softMin = -400,
      softMax = 400,
  		-- desc = '',
      set = function(info, val)
        addon.Settings.db.profile.target.nameY = val
        addon:UpdateSize()
      end,
  		get = function(info) return addon.Settings.db.profile.target.nameY end,
    },


    spacing = {
      name = 'Horizonal Spacing',
      desc = "How much space between the left and right bars?",
  		type = 'range',
      order = 4,
      softMin = 0,
      softMax = 600,
      set = function(info, val)
        addon.Settings.db.profile.spacing = val
        addon:UpdateSize()
      end,
  		get = function(info) return addon.Settings.db.profile.spacing end,
    },


    spacingY = {
      name = 'Vertical Spacing',
      desc = "How much space between the unit and target frames?",
  		type = 'range',
      order = 4,
      softMin = 0,
      softMax = 600,
      set = function(info, val)
        addon.Settings.db.profile.spacingY = val
        addon:UpdateSize()
      end,
  		get = function(info) return addon.Settings.db.profile.spacingY end,
    },

    width = {
  		name = 'Frame Width',
  		type = 'range',
      order = 4,
      softMin = 30,
      softMax = 600,
      set = function(info, val)
        addon.Settings.db.profile.width = val
        addon:UpdateSize()
      end,
  		get = function(info) return addon.Settings.db.profile.width end,
    },

    height = {
  		name = 'Bar Height',
  		type = 'range',
      order = 5,
      softMin = 1,
      softMax = 40,
      set = function(info, val)
        addon.Settings.db.profile.height = val
        addon:UpdateSize()
      end,
  		get = function(info) return addon.Settings.db.profile.height end,
    },


    blah2 = {
      name = "Font",
      type = "header",
      order = 6
    },

    font = {
      name = 'Font Family',
      type = 'select',
      order = 7,
      sorting = function(values, ...)
        local keys = {}
        for _, v in spairs(LSM:HashTable("font")) do table.insert(keys, v) end
        return keys
      end,
      values = function()
        local values = {}
        for k, v in pairs(LSM:HashTable("font")) do
          values[v] = k
        end
        return values
      end,
      set = function(info, val)
        addon.Settings.db.profile.font = val
        addon:UpdateFont()
      end,
      get = function(info) return addon.Settings.db.profile.font end,
    },

    fontSize = {
  		name = 'Font Size',
  		type = 'range',
      order = 8,
      softMin = 4,
      softMax = 46,
      set = function(info, val)
        addon.Settings.db.profile.fontSize = val
        addon:UpdateFont()
      end,
  		get = function(info) return addon.Settings.db.profile.fontSize end,
    },

    modelOptions = {

      name = "Model Options",
      type = 'group',

      args = {
        showPortrait = {
          name = 'Show 3d target model',
          type = 'toggle',
          order = 0,
          set = function(info, val)
            addon.Settings.db.profile.showPortrait = val
            addon.targetUnitFrame:TogglePortrait()
          end,
          get = function(info)
            return addon.Settings.db.profile.showPortrait
          end,
        },

        camera = {
          name = "Camera",
          type = "header",
          order = 1
        },

        x = {
          name = 'x',
          type = 'range',
          order = 2,
          softMin = -100,
          softMax = 100,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.camera.x = val
            model:SetCameraPosition(addon.Settings.db.profile.camera.x, addon.Settings.db.profile.camera.y, addon.Settings.db.profile.camera.z)
          end,
          get = function(info)
            return addon.Settings.db.profile.camera.x
          end,
        },
        y = {
          name = 'y',
          type = 'range',
          order = 3,
          softMin = -100,
          softMax = 100,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.camera.y = val
            model:SetCameraPosition(addon.Settings.db.profile.camera.x, addon.Settings.db.profile.camera.y, addon.Settings.db.profile.camera.z)
          end,
          get = function(info)
            return addon.Settings.db.profile.camera.y
          end,
        },
        z = {
          name = 'z',
          type = 'range',
          order = 4,
          softMin = -100,
          softMax = 100,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.camera.z = val
            model:SetCameraPosition(addon.Settings.db.profile.camera.x, addon.Settings.db.profile.camera.y, addon.Settings.db.profile.camera.z)
          end,
          get = function(info)
            return addon.Settings.db.profile.camera.z
          end,
        },
        -- distance = {
        --   name = 'distance',
        --   type = 'range',
        --   order = 4.5,
        --   softMin = -100,
        --   softMax = 100,
        --   set = function(info, val)
        --     local model = addon.targetUnitFrame.portrait
        --     addon.Settings.db.profile.camera.distance = val
        --     model:SetCameraDistance(addon.Settings.db.profile.camera.distance)
        --   end,
        --   get = function(info)
        --     return addon.Settings.db.profile.camera.distance
        --   end,
        -- },

        model = {
          name = "Model",
          type = "header",
          order = 5
        },
        posx = {
          name = 'x',
          type = 'range',
          order = 6,
          softMin = -100,
          softMax = 100,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.x = val
            model:SetPosition(addon.Settings.db.profile.model.x, addon.Settings.db.profile.model.y, addon.Settings.db.profile.model.z)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.x
          end,
        },
        posy = {
          name = 'y',
          type = 'range',
          order = 7,
          softMin = -100,
          softMax = 100,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.y = val
            model:SetPosition(addon.Settings.db.profile.model.x, addon.Settings.db.profile.model.y, addon.Settings.db.profile.model.z)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.y
          end,
        },
        posz = {
          name = 'z',
          type = 'range',
          order = 8,
          softMin = -100,
          softMax = 100,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.z = val
            model:SetPosition(addon.Settings.db.profile.model.x, addon.Settings.db.profile.model.y, addon.Settings.db.profile.model.z)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.z
          end,
        },

        scale = {
          name = 'scale',
          type = 'range',
          order = 9,
          softMin = -10,
          softMax = 10,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.scale = val
            model:SetPortraitZoom(addon.Settings.db.profile.model.scale)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.scale
          end,
        },

        rotation = {
          name = 'rotation',
          type = 'range',
          order = 10,
          min = 0,
          max = math.rad(360),
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.rotation = val
            model:SetFacing(addon.Settings.db.profile.model.rotation)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.rotation
          end,
        },

        pitch = {
          name = 'pitch',
          type = 'range',
          order = 11,
          min = 0,
          max = math.rad(360),
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.pitch = val
            model:SetPitch(addon.Settings.db.profile.model.pitch)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.pitch
          end,
        },

        animation = {
          name = 'animation',
          type = 'range',
          order = 11,
          min = 0,
          max = 208,
          step = 1,
          set = function(info, val)
            local model = addon.targetUnitFrame.portrait
            addon.Settings.db.profile.model.animation = val
            model:SetAnimation(addon.Settings.db.profile.model.animation)
          end,
          get = function(info)
            return addon.Settings.db.profile.model.animation
          end,
        },
      }
    }
  }
}

function Options:OnLoad()
  AceConfig:RegisterOptionsTable(addonName, addon.Options.primary, { "vikinghud", "vh" })
  AceConfigDialog:AddToBlizOptions(addonName, addonName)
  local profiles = AceDBOptions:GetOptionsTable(addon.Settings.db)
  AceConfig:RegisterOptionsTable(addonName .. ".profiles", profiles)
  AceConfigDialog:AddToBlizOptions(addonName .. ".profiles", "Profiles", addonName)

  --@debug@
  -- AceConfig:RegisterOptionsTable(addonName .. ".model", modelOptions, {"model"})
  --@debug end@
end

-- function Options:OpenModelOptions()
--   --@debug@
--   if not AceConfigDialog.OpenFrames[addonName .. ".model"] then
--     AceConfigDialog:Open(addonName .. ".model")
--   end
--   --@debug end@
-- end
