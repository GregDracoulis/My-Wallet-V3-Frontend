describe "SettingsAddressesCtrl", ->
  scope = undefined
  Wallet = undefined
  
  modal =
    open: ->
  
  beforeEach angular.mock.module("walletApp")
  
  beforeEach ->
    angular.mock.inject ($injector, $rootScope, $controller) ->
      Wallet = $injector.get("Wallet")
      MyWallet = $injector.get("MyWallet")
      
      Wallet.login("test", "test")  
      
      scope = $rootScope.$new()
            
      $controller "SettingsAddressesCtrl",
        $scope: scope,
        $stateParams: {}
        $modal: modal
      
      return
      
    return

    
  describe "legacy addresses", ->
    it "should be listed", ->
      expect(scope.legacyAddresses.length).toBeGreaterThan(0)
     
    it "can be archived", ->
      address = scope.legacyAddresses[0]
      expect(address.active).toBe(true)
      scope.archive(address)
      expect(address.active).toBe(false)
      
    it "can be unarchived", ->
      address = scope.legacyAddresses[3]
      expect(address.active).toBe(false)
      scope.unarchive(address)
      expect(address.active).toBe(true)
      
    it "can be deleted", inject((Wallet) ->
      spyOn(window, 'confirm').and.callFake(() ->
        return true
      )
      
      address = scope.legacyAddresses[3]
      before = scope.legacyAddresses.length
      
      spyOn(Wallet, "deleteLegacyAddress").and.callThrough()
      
      scope.delete(address)
      expect(Wallet.deleteLegacyAddress).toHaveBeenCalled()
      expect(scope.legacyAddresses.length).toBe(before - 1)
    )
    
  describe "importAddress()", ->
    it "should open a modal",  inject(($modal) ->
      spyOn(modal, "open")
      scope.importAddress()
      expect(modal.open).toHaveBeenCalled()
    )
    
  describe "signMessage()", ->
    it "should open a modal",  inject(($modal) ->
      spyOn(modal, "open")
      scope.signMessage()
      expect(modal.open).toHaveBeenCalled()
    )