walletApp.controller "DashboardCtrl", ($scope, Wallet, $log, $modal) ->
  $scope.accounts = Wallet.accounts
  $scope.status = Wallet.status
  $scope.paymentRequestAddress = null  

  $scope.setPaymentRequestURL = (address, amount) ->
    $scope.paymentRequestAddress = address
    $scope.paymentRequestURL = "bitcoin:" + address
    if amount? && amount > 0
      $scope.paymentRequestURL += "?amount=" + numeral(amount).divide(100000000)

  $scope.updatePaymentInfo = () ->
    defaultAcctIdx = Wallet.getDefaultAccountIndex()
    receiveAddress = Wallet.getReceivingAddressForAccount(defaultAcctIdx)
    $scope.setPaymentRequestURL(receiveAddress)

  $scope.updateDoughnutChart = () ->
    $scope.accounts().map((account) -> 
      if account.balance?
        return account.balance
    )

  $scope.$watchCollection 'accounts()', () ->
    $scope.updatePaymentInfo()
    $scope.data = $scope.updateDoughnutChart()
    if $scope.data.length < 3
      $scope.data.push 0
    return

  if $scope.status.firstTime
    modalInstance = $modal.open(
      templateUrl: "partials/first-login-modal.jade"
      controller: "FirstTimeCtrl"
      resolve:
        firstTime: ->
          Wallet.status.firstTime = false
      windowClass: "bc-modal rocket-modal"
    )

  $scope.labels = ['Download Sales', "In-Store Sales", "Mail-Order Sales"]
  $scope.options = showTooltips : true # (2) NOT WORKING AS OF YET...TODO:LABELS
  