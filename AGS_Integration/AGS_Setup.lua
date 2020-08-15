function MasterMerchant:initAGSIntegration()
  --MasterMerchant.dm("Verbose", "MasterMerchant:initAGSIntegration")
  if AwesomeGuildStore.GetAPIVersion == nil then return end
  --MasterMerchant.dm("Verbose", "AwesomeGuildStore.GetAPIVersion")
  if AwesomeGuildStore.GetAPIVersion() ~= 4 then return end

  local FILTER_ID = AwesomeGuildStore:GetFilterIds()

  local DealFilter = MasterMerchant.InitDealFilterClass()
  local DealFilterFragment = MasterMerchant.InitDealFilterFragmentClass()

  local ProfitFilter = MasterMerchant.InitProfitFilterClass()
  AwesomeGuildStore:RegisterCallback(AwesomeGuildStore.callback.AFTER_FILTER_SETUP,
    function(...)
      AwesomeGuildStore:RegisterFilter(DealFilter:New())
      AwesomeGuildStore:RegisterFilterFragment( DealFilterFragment:New(FILTER_ID.MASTER_MERCHANT_DEAL_FILTER))
      if self:ActiveSettings().minProfitFilter then
        AwesomeGuildStore:RegisterFilter(ProfitFilter:New())
        AwesomeGuildStore:RegisterFilterFragment( AwesomeGuildStore.class.PriceRangeFilterFragment:New(FILTER_ID.MASTER_MERCHANT_DEAL_SELECTOR))
      end
    end
  )
end

