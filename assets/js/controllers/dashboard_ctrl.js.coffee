walletApp.controller "DashboardCtrl", ($scope, Wallet, $log, $modal) ->
  $scope.accounts = Wallet.accounts
  $scope.status = Wallet.status
  $scope.paymentRequestAddress = null
  $scope.doughnutData = []

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
    console.log $scope.accounts().map((account) -> 
      return account.balance
    )

  $scope.$watchCollection 'accounts()', () ->
    $scope.updatePaymentInfo()
    $scope.updateDoughnutChart()
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

  $scope.labels = ["Download Sales", "In-Store Sales", "Mail-Order Sales"];
  $scope.data = [300, 500, 100];


