walletApp.controller "HomeCtrl", ($scope, $window, Wallet, $modal, $http) ->
  $scope.accounts = Wallet.accounts
  $scope.status = Wallet.status
  $scope.settings = Wallet.settings
  $scope.getTotal = () -> Wallet.total('accounts')
  $scope.empty = false
  $scope.loading = true
  $scope.transactions = []
  $scope.historicalBalanceData = [ {
    key: 'Balance Over Time'
    values: []
  }]

  $scope.getHistoricalBalance = () ->
    endpoint = '/balance-over-time'
    endpoint += $scope.accounts().reduce (prev, current) ->
      return prev + current.extendedPublicKey + '|'
    , '?addresses='
    $http.get(endpoint).then (response) ->
      $scope.historicalBalanceData[0].values = response.data

  $scope.chartColor = () ->
    return (d, i) ->
      return '#D5EFF9'

  $scope.xAxisTickFormatFunction = ->
    (d) ->
      d3.time.format('%x') new Date(d)

  #TODO convert to currency for value instead of balance
  # $scope.yAxisTickFormatFunction = ->

  # Watchers
  loadedTxs = $scope.$watch 'status.didLoadTransactions', (didLoad) ->
    return unless didLoad
    $scope.transactions = Wallet.transactions
    loadedTxs()

  loadedBalances = $scope.$watch 'status.didLoadBalances', (didLoad) ->
    return unless didLoad
    $scope.getHistoricalBalance()
    loadedBalances()
    $scope.loading = false
  
  # Modals
  $scope.newAccount = () ->
    modalInstance = $modal.open(
      templateUrl: "partials/account-form.jade"
      controller: "AccountFormCtrl"
      resolve:
        account: -> undefined
      windowClass: "bc-modal small"
    )

  if $scope.status.firstTime
    modalInstance = $modal.open(
      templateUrl: "partials/first-login-modal.jade"
      controller: "FirstTimeCtrl"
      resolve:
        firstTime: ->
          Wallet.status.firstTime = false
      windowClass: "bc-modal rocket-modal"
    )

  $scope.getHistoricalBalance()
