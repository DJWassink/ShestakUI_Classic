local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Friends skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"FriendsFrame",
		"FriendsListFrame",
		"FriendsTabHeader",
		"FriendsFrameFriendsScrollFrame",
		"WhoFrameColumnHeader1",
		"WhoFrameColumnHeader2",
		"WhoFrameColumnHeader3",
		"WhoFrameColumnHeader4",
		"AddFriendFrame",
		"AddFriendNoteFrame",
		"FriendsFriendsFrame",
		"FriendsFriendsList",
		"IgnoreListFrame",
		"FriendsFrameInset",
		"WhoFrameListInset",
		"WhoFrameEditBoxInset",
		"LFRQueueFrameListInset",
		"LFRQueueFrameRoleInset",
		"LFRQueueFrameCommentInset",
		"ScrollOfResurrectionSelectionFrame",
		"ScrollOfResurrectionSelectionFrameList",
		"ScrollOfResurrectionFrame",
		"ScrollOfResurrectionFrameNoteFrame",
		"FriendsFrameBattlenetFrame",
		"BattleTagInviteFrame",
		"RecruitAFriendNoteFrame",
		"QuickJoinScrollFrame",
		"QuickJoinRoleSelectionFrame"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local KillTextures = {
		"FriendsFrameIcon",
		"FriendsFrameBroadcastInputLeft",
		"FriendsFrameBroadcastInputRight",
		"FriendsFrameBroadcastInputMiddle"
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		"FriendsFrameAddFriendButton",
		"FriendsFrameSendMessageButton",
		"WhoFrameWhoButton",
		"WhoFrameAddFriendButton",
		"WhoFrameGroupInviteButton",
		"FriendsFrameIgnorePlayerButton",
		"FriendsFrameUnsquelchButton",
		"AddFriendEntryFrameAcceptButton",
		"AddFriendEntryFrameCancelButton",
		"AddFriendInfoFrameContinueButton",
		"FriendsFriendsCloseButton",
		"FriendsFriendsSendRequestButton",
		"ScrollOfResurrectionSelectionFrameAcceptButton",
		"ScrollOfResurrectionSelectionFrameCancelButton",
		"ScrollOfResurrectionFrameAcceptButton",
		"ScrollOfResurrectionFrameCancelButton",
		"RecruitAFriendFrameSendButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end

	local scrollbars = {
		"FriendsFrameFriendsScrollFrameScrollBar",
		"FriendsFrameIgnoreScrollFrameScrollBar",
		"FriendsFriendsScrollFrameScrollBar",
		"WhoListScrollFrameScrollBar",
		"QuickJoinScrollFrameScrollBar"
	}

	for _, scrollbar in pairs(scrollbars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	-- Reposition buttons
	WhoFrameWhoButton:SetPoint("RIGHT", WhoFrameAddFriendButton, "LEFT", -3, 0)
	WhoFrameAddFriendButton:SetPoint("RIGHT", WhoFrameGroupInviteButton, "LEFT", -3, 0)
	WhoFrameGroupInviteButton:SetPoint("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameAddFriendButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameSendMessageButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameIgnorePlayerButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameUnsquelchButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)

	-- Resize Buttons
	WhoFrameWhoButton:SetSize(WhoFrameWhoButton:GetWidth() + 7, WhoFrameWhoButton:GetHeight())
	WhoFrameAddFriendButton:SetSize(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
	WhoFrameGroupInviteButton:SetSize(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
	T.SkinEditBox(WhoFrameEditBox, WhoFrameEditBox:GetWidth() + 30, WhoFrameEditBox:GetHeight() - 15)
	WhoFrameEditBox:SetPoint("BOTTOM", WhoFrame, "BOTTOM", 0, 31)

	T.SkinEditBox(AddFriendNameEditBox)
	AddFriendNameEditBox:SetHeight(AddFriendNameEditBox:GetHeight() - 5)
	AddFriendFrame:SetTemplate("Transparent")
	FriendsFriendsFrame:SetTemplate("Transparent")
	FriendsFriendsList:SetTemplate("Overlay")

	-- Quick Join Frame
	QuickJoinFrame.JoinQueueButton:SkinButton()
	QuickJoinRoleSelectionFrame:SetTemplate("Transparent")
	QuickJoinRoleSelectionFrame.AcceptButton:SkinButton()
	QuickJoinRoleSelectionFrame.CancelButton:SkinButton()
	T.SkinCloseButton(QuickJoinRoleSelectionFrame.CloseButton)
	T.SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonTank.CheckButton)
	T.SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonHealer.CheckButton)
	T.SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonDPS.CheckButton)

	-- Pending invites
	FriendsFrameFriendsScrollFrame.PendingInvitesHeaderButton:SkinButton()
	local function SkinFriendRequest(frame)
		if not frame.isSkinned then
			frame.DeclineButton:SetPoint("RIGHT", frame, "RIGHT", -2, 1)
			frame.DeclineButton:SkinButton()
			frame.AcceptButton:SkinButton()
			frame.isSkinned = true
		end
	end
	hooksecurefunc(FriendsFrameFriendsScrollFrame.invitePool, "Acquire", function()
		for object in pairs(FriendsFrameFriendsScrollFrame.invitePool.activeObjects) do
			SkinFriendRequest(object)
		end
	end)

	-- Who Frame
	local function UpdateWhoSkins()
		WhoListScrollFrame:StripTextures()
	end

	WhoFrame:HookScript("OnShow", UpdateWhoSkins)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

	WhoListScrollFrame:ClearAllPoints()
	WhoListScrollFrame:SetPoint("TOPRIGHT", WhoFrameListInset, -25, 0)

	-- BNet Frame
	FriendsFrameBroadcastInput:CreateBackdrop("Overlay")
	FriendsFrameBroadcastInput.backdrop:SetPoint("TOPLEFT", -2, 2)
	FriendsFrameBroadcastInput.backdrop:SetPoint("BOTTOMRIGHT", 0, 1)

	FriendsFrameBattlenetFrame.BroadcastButton:SetAlpha(0)
	FriendsFrameBattlenetFrame.BroadcastButton:ClearAllPoints()
	FriendsFrameBattlenetFrame.BroadcastButton:SetAllPoints(FriendsFrameBattlenetFrame)

	FriendsFrameBattlenetFrame.BroadcastFrame:StripTextures()
	FriendsFrameBattlenetFrame.BroadcastFrame:CreateBackdrop("Transparent")
	FriendsFrameBattlenetFrame.BroadcastFrame.backdrop:SetPoint("TOPLEFT", 1, 1)
	FriendsFrameBattlenetFrame.BroadcastFrame.backdrop:SetPoint("BOTTOMRIGHT", 1, 1)

	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame:StripTextures()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame:CreateBackdrop("Overlay")
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.backdrop:SetPoint("TOPLEFT", -2, 4)
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.CancelButton:SkinButton()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.UpdateButton:SkinButton()

	FriendsFrameBattlenetFrame.UnavailableInfoFrame:StripTextures()
	FriendsFrameBattlenetFrame.UnavailableInfoFrame:CreateBackdrop("Transparent")
	FriendsFrameBattlenetFrame.UnavailableInfoFrame.backdrop:SetPoint("TOPLEFT", 4, -4)
	FriendsFrameBattlenetFrame.UnavailableInfoFrame.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)

	BattleTagInviteFrame:SetTemplate("Transparent")
	for i = 1, BattleTagInviteFrame:GetNumChildren() do
		local child = select(i, BattleTagInviteFrame:GetChildren())
		if child:GetObjectType() == "Button" then
			child:SkinButton()
		end
	end

	FriendsFrame:SetTemplate("Transparent")

	ScrollOfResurrectionSelectionFrame:SetTemplate("Transparent")
	ScrollOfResurrectionSelectionFrameList:SetTemplate("Overlay")
	T.SkinEditBox(ScrollOfResurrectionSelectionFrameTargetEditBox, nil, ScrollOfResurrectionSelectionFrameTargetEditBox:GetHeight() - 5)

	ScrollOfResurrectionFrame:SetTemplate("Transparent")
	ScrollOfResurrectionFrameNoteFrame:SetTemplate("Overlay")
	T.SkinEditBox(ScrollOfResurrectionFrameTargetEditBox, nil, ScrollOfResurrectionFrameTargetEditBox:GetHeight() - 5)

	RecruitAFriendFrame:SetTemplate("Transparent")
	T.SkinCloseButton(RecruitAFriendFrameCloseButton)
	T.SkinEditBox(RecruitAFriendNameEditBox)
	T.SkinEditBox(RecruitAFriendNoteFrame)

	RecruitAFriendSentFrame:SetTemplate("Transparent")
	RecruitAFriendSentFrame.OKButton:SkinButton()
	T.SkinCloseButton(RecruitAFriendSentFrameCloseButton)

	FriendsTabHeaderSoRButton:SetTemplate("Default")
	FriendsTabHeaderSoRButton:StyleButton()
	FriendsTabHeaderSoRButton.icon:SetDrawLayer("OVERLAY")
	FriendsTabHeaderSoRButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	FriendsTabHeaderSoRButton.icon:ClearAllPoints()
	FriendsTabHeaderSoRButton.icon:SetPoint("TOPLEFT", 2, -2)
	FriendsTabHeaderSoRButton.icon:SetPoint("BOTTOMRIGHT", -2, 2)

	FriendsTabHeaderRecruitAFriendButton:SetTemplate("Default")
	FriendsTabHeaderRecruitAFriendButton:StyleButton()
	FriendsTabHeaderRecruitAFriendButton:SetSize(23, 23)
	FriendsTabHeaderRecruitAFriendButton:ClearAllPoints()
	FriendsTabHeaderRecruitAFriendButton:SetPoint("TOPRIGHT", FriendsFrame, -9, -58)
	FriendsTabHeaderRecruitAFriendButtonIcon:SetDrawLayer("OVERLAY")
	FriendsTabHeaderRecruitAFriendButtonIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	FriendsTabHeaderRecruitAFriendButtonIcon:ClearAllPoints()
	FriendsTabHeaderRecruitAFriendButtonIcon:SetPoint("TOPLEFT", 2, -2)
	FriendsTabHeaderRecruitAFriendButtonIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	FriendsFrameStatusDropDown:SetPoint("TOPLEFT", 1, -27)

	for i = 1, FRIENDS_TO_DISPLAY do
		local button = _G["FriendsFrameFriendsScrollFrameButton"..i]
		local icon = button.gameIcon

		icon.b = CreateFrame("Frame", nil, button)
		icon.b:SetTemplate("Default")
		icon.b:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
		icon.b:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

		icon:SetParent(icon.b)
		icon:SetSize(22, 22)
		icon:SetTexCoord(.15, .85, .15, .85)
		icon:ClearAllPoints()
		icon:SetPoint("RIGHT", button, "RIGHT", -24, 0)
		icon.SetPoint = T.dummy

		button.travelPassButton:SetSize(20, 32)
		button.travelPassButton:SkinButton()
		button.background:Hide()

		button.inv = button.travelPassButton:CreateTexture(nil, "OVERLAY", nil, 7)
		button.inv:SetTexture([[Interface\FriendsFrame\PlusManz-PlusManz]])
		button.inv:SetPoint("TOPRIGHT", 1, -4)
		button.inv:SetSize(22, 22)
	end

	hooksecurefunc("FriendsFrame_UpdateFriendButton", function(button)
		if button.buttonType == _G.FRIENDS_BUTTON_TYPE_BNET then
			local isEnabled = button.travelPassButton:IsEnabled()
			if button.inv then
				button.travelPassButton:SetAlpha(isEnabled and 1 or 0.4)
				button.gameIcon.b:SetShown(button.gameIcon:IsShown())
			end
		else
			if button.gameIcon.b then
				button.gameIcon.b:SetShown(button.gameIcon:IsShown())
			end	
		end
	end)

	T.SkinCloseButton(FriendsFrameCloseButton)
	T.SkinDropDownBox(WhoFrameDropDown, 150)
	T.SkinDropDownBox(FriendsFrameStatusDropDown, 70)
	T.SkinDropDownBox(FriendsFriendsFrameDropDown)

	T.SkinHelpBox(FriendsTabHeader.FriendsFrameQuickJoinHelpTip)

	-- Bottom Tabs
	for i = 1, 4 do
		T.SkinTab(_G["FriendsFrameTab"..i])
	end

	for i = 1, 3 do
		T.SkinTab(_G["FriendsTabHeaderTab"..i], true)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)