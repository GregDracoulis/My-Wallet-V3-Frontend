walletApp.controller "RecoveryCtrl", ($scope, $rootScope, Wallet, $state, $translate) ->
  $scope.recoveryPhrase = null
  $scope.recoveryPassphrase = null
  $scope.showRecoveryPhrase = false
  $scope.editMnemonic = false
  $scope.status = Wallet.status


  $scope.isValidMnemonic = Wallet.isValidBIP39Mnemonic

  $scope.toggleRecoveryPhrase = () ->
    if !$scope.showRecoveryPhrase
      success = (mnemonic, passphrase) ->
        $scope.recoveryPhrase = mnemonic
        $scope.recoveryPassphrase = passphrase
        $scope.showRecoveryPhrase = true
        
      error = (message) ->
        
      Wallet.getMnemonic(success, error)
    else
      $scope.recoveryPhrase = null
      $scope.recoveryPassphrase = null
      $scope.showRecoveryPhrase = false

  $scope.importRecoveryPhrase = () ->
    $scope.editMnemonic = true

  $scope.performImport = () ->

    success = () ->
      $scope.importing = false
      $scope.editMnemonic = false
      $scope.mnemonic = null
      $state.go("wallet.common.transactions", accountIndex: "accounts")
      Wallet.displaySuccess("Successfully imported seed")

    error = (message) ->
      $scope.importing = false
      Wallet.displayError(message)
      
    cancel = () ->
      $scope.importing = false

    if confirm("You will lose all your bitcoins! Are you sure?")
      $scope.importing = true
      Wallet.importWithMnemonic($scope.mnemonic, $scope.passphrase, success, error, cancel)

    return

  $scope.doNotCopyPaste = (event) ->
    event.preventDefault()
    $translate("DO_NOT_COPY_PASTE").then (translation) ->
      Wallet.displayWarning translation

  #############################################
  #### Wallet recovery from login page ########
  #############################################

  $scope.currentStep = 1
  $scope.nextStep = () ->
    $scope.currentStep++
  $scope.goBack = () ->
    $scope.currentStep--
  $scope.fields = {email: "", password: "", confirmation: "", mnemonic: "", bip39phrase: ""}
  $scope.errors = {email: null, password: null, confirmation: null}
  $scope.success = {email: false, password: false, confirmation: false}
  $scope.isValid = [true, true]

  if $scope.fields.email == ""
    $scope.isValid[0] = false
    $translate("EMAIL_ADDRESS_REQUIRED").then (translation) ->
      $scope.errors.email = translation
  else if $scope.form && $scope.form.$error.email
    $scope.isValid[0] = false
    $translate("EMAIL_ADDRESS_INVALID").then (translation) ->
      $scope.errors.email = translation
  else
     $scope.success.email = true

  if $scope.form && $scope.form.$error
    if $scope.form.$error.minEntropy
      $scope.isValid[0] = false
      $translate("TOO_WEAK").then (translation) ->
        $scope.errors.password =  translation
    if $scope.form.$error.maxlength
      $scope.isValid[0] = false
      $translate("TOO_LONG").then (translation) ->
        $scope.errors.password =  translation

  if $scope.fields.confirmation == ""
    $scope.isValid[0] = false
  else
    if $scope.fields.confirmation == $scope.fields.password
      $scope.success.confirmation = true
    else
      $scope.isValid[0] = false
      if visual
        $translate("NO_MATCH").then (translation) ->
          $scope.errors.confirmation = translation
