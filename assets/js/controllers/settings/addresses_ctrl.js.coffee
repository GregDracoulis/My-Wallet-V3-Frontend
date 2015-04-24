@SettingsAddressesCtrl = ($scope, Wallet, $translate, $modal, $state) ->
  $scope.legacyAddresses = Wallet.legacyAddresses
  $scope.accounts = Wallet.accounts
  $scope.display = {archived: false, account_dropdown_open: false}  
  
  $scope.settings = Wallet.settings
  
  $scope.hdAddresses = Wallet.hdAddresses
  
  $scope.addAddressForAccount = (account) ->
    
    success = (address) ->
      $state.go "wallet.common.settings.address", {address: address.address}
      
    error = () ->
      
    Wallet.addAddressForAccount(account, success, error)
  
  $scope.clear = (request) ->
    Wallet.cancelPaymentRequest(request.account, request.address)
    
  $scope.archive = (address) ->
    Wallet.archive(address)
    
  $scope.unarchive = (address) ->
    Wallet.unarchive(address)
    
  $scope.delete = (address) ->
    $translate("LOSE_ACCESS").then (translation) ->    
      if confirm translation
        Wallet.deleteLegacyAddress(address)
        
  $scope.importAddress = () ->
    Wallet.clearAlerts()
    modalInstance = $modal.open(
      templateUrl: "partials/settings/import-address.jade"
      controller: AddressImportCtrl
      windowClass: "blockchain-modal"
    )
    
  $scope.transfer = (address) ->
    $modal.open(
      templateUrl: "partials/send.jade"
      controller: SendCtrl
      resolve:
        paymentRequest: -> 
          {fromAddress: address, amount: 0, toAccount: Wallet.accounts[Wallet.getDefaultAccountIndex()]}
    )

  $scope.showPrivKey = (address) ->
    $modal.open(
      templateUrl: "partials/settings/show-private-key.jade"
      controller: ShowPrivateKeyCtrl
      resolve:
        addressObj: ->
          address
    )

  $scope.signMessage = () ->
    Wallet.clearAlerts()
    modalInstance = $modal.open(
      templateUrl: "partials/sign-message.jade"
      controller: SignMessageCtrl
      windowClass: "blockchain-modal"
    )

  #################################
  #           Private             #
  #################################
  
  $scope.didLoad = () ->
    $scope.requests = Wallet.paymentRequests
    
  # First load:      
  $scope.didLoad()