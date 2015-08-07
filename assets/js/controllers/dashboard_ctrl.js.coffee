walletApp.controller "DashboardCtrl", ($scope, Wallet, $log, $modal) ->
  $scope.accounts = Wallet.accounts
  $scope.status = Wallet.status
  $scope.paymentRequestAddress = null
  $scope.array = []

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
        $scope.array.push([account.label, account.balance])
        return account.label + account.balance
    )

  $scope.$watchCollection 'accounts()', () ->
    $scope.updatePaymentInfo()
    console.log $scope.data = $scope.updateDoughnutChart()
    console.log $scope.array
    if $scope.data.length < 3
      $scope.array.push(["",0])
    console.log $scope.array
    return

  $scope.$watchCollection 'array', () ->
    $scope.draw()

  if $scope.status.firstTime
    modalInstance = $modal.open(
      templateUrl: "partials/first-login-modal.jade"
      controller: "FirstTimeCtrl"
      resolve:
        firstTime: ->
          Wallet.status.firstTime = false
      windowClass: "bc-modal rocket-modal"
    )

  $scope.draw = () ->
    # Create the chart
    chart = new (Highcharts.Chart)(
      chart:
        renderTo: 'container'
        type: 'pie'
      title: text: 'Account Balances'
      yAxis: title: text: 'Total Balance'
      plotOptions: pie: shadow: false
      tooltip: formatter: ->
        '<b>' + @point.name + '</b>: ' + @y + ' %'
      series: [ {
        name: 'Browsers'
        data: $scope.array
        size: '60%'
        innerSize: '20%'
        showInLegend: true
        dataLabels: enabled: false
      } ]
      credits: {
        enabled: false
        })
    return