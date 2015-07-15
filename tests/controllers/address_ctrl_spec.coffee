describe "AddressCtrl", ->
  scope = undefined
  Wallet = undefined

  modal =
    open: ->

  beforeEach angular.mock.module("walletApp")

  beforeEach ->
    angular.mock.inject ($injector, $rootScope, $controller) ->
      Wallet = $injector.get("Wallet")
      MyWallet = $injector.get("MyWallet")

      MyWallet.wallet = {
        keys: [{ address: 'some_legacy_address', label: 'Old' }]
        hdwallet: {
          accounts: [{
            receiveAddress: { address: 'hd_account_address' }
          }]
        }
      }

      Wallet.changeAddressLabel = (-> )

      Wallet.updateLegacyAddresses()
      Wallet.updateAccounts()
      Wallet.updateHDaddresses()

      scope = $rootScope.$new()

      $controller "AddressCtrl",
        $scope: scope,
        $stateParams: {address: "some_legacy_address"}
        $modal: modal

    scope.$digest()

  it "should show the address and label",  inject((Wallet) ->
    expect(scope.address).toBeDefined()
    expect(scope.address.address).toBe("some_legacy_address")
    expect(scope.address.label).toBe("Old")
  )

  it "should change the address",  inject((Wallet) ->
    spyOn(Wallet, "changeAddressLabel").and.callThrough()
    scope.changeLabel("New Label")
    expect(Wallet.changeAddressLabel).toHaveBeenCalled()
  )
