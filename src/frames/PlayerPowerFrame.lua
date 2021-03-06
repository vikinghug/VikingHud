local LSM = LibStub("LibSharedMedia-3.0")
local VSL = LibStub("VikingSharedLib")
local Taka = LibStub("Taka-0.0")

local addonName, addon = ...

local PlayerPowerFrame = Taka:NewClass("Frame", "VH_PowerFrame")
addon.PlayerPowerFrame = PlayerPowerFrame

local MANA = 0
local RAGE = 1
local ENERGY = 3

function PlayerPowerFrame:New(parent, side, unitID, powerType)
  local frame = PlayerPowerFrame:Super(PlayerPowerFrame):New(parent)
  frame:SetSize(addon.Settings.db.profile.width, addon.Settings.db.profile.height)

  frame.unitID = unitID
  frame.powerType = powerType

  frame.statusBar = addon.StatusBar:New(frame)

  local color

  if powerType == MANA then
    color = VSL.Colors.BLUE
  elseif powerType == RAGE then
    color = VSL.Colors.ORANGE
  elseif powerType == ENERGY then
    color = VSL.Colors.YELLOW
  end

  frame.statusBar:SetBarColor(color:ToList(1.0))
  frame.statusBar:SetBackdropColor(VSL.Colors.BG:ToList(0.8))
  frame:Hide()

  return frame
end

function PlayerPowerFrame:UpdateFont()
  self.statusBar:UpdateFont()
end

function PlayerPowerFrame:Update()
  self.statusBar:SetValues(
    0,
    UnitPowerMax(self.unitID, self.powerType),
    UnitPower(self.unitID, self.powerType)
  )
  return self
end

function PlayerPowerFrame:Unregister()
  self.statusBar:Unregister()
end

function PlayerPowerFrame:Register()
  self.statusBar:Register()
end
