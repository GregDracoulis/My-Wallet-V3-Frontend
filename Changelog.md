__Blockchain HD Frontend__

_Recent changes_

#   (2015-09-03)



---

## Bug Fixes

- **Send:** pasted watch only address sticks
  ([017735b5](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/017735b5a059c665ee893185641363daa4ea13e4))
- **UI:**
  - hide input spinners on -webkit, change class name on bc-async-input (padding only necessary)
  ([e9f1a11c](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/e9f1a11cff5046992c02aa45621598e1b06581ed))
  - normalize search fields so they match transactions screen, make sure buttons don't break
  ([aed74541](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/aed745416be573cffbb2e0853235ced0ab129122))
  - use some creative css to make sure sections don't overlap across various screen sizes in the home page
  ([0958dd07](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/0958dd0753f50ac0cf12bbd5ac12ee6c5aa5d540))
  - move alerts in app to top right, fix authorization success msg, fix helper text widths on smaller screens, give max-height to advanced send modals
  ([d7f6e623](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/d7f6e623937415ca61e3b77e352d4bd395597b9f))
  - remove auto margin so that IE can flex correctly
  ([0931d56b](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/0931d56b1173fbc40caa774743b8223d23150987))
  - simplify navbar logo/menu CSS
  ([5098145b](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/5098145bac3fe58c1de4a5b614e0df303189cd95))
  - rm .form-group class from directive
  ([94bb3a6c](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/94bb3a6cef9c4ef7e8f210bb427a499d41b5496b))
- **addresses:** prevent user from generating HD address after upgrade before sync is complete
  ([86e8cd8c](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/86e8cd8c17ecfd05d28bfe0f19f9d507ad984587))
- **bc-async-input:** cancel after submit no longer undoes the previous change
  ([4d38ad77](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/4d38ad77f20e6f2cae32b1fc002b6aba61d253cd))
- **contextualMessage:** add missing 0 to balance check
  ([120e947b](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/120e947b1b13ae97ce6f3fd24ec5bbc188a0858a))
- **empty-state:** remove unnecessary check which was causing it not to appear correctly
  ([b654f796](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/b654f796729aea088e359399b398d4bec4b4a1eb))
- **mobile-safari:** change header css so icons align nicely, remove unnecessary padding and margin + old css
  ([0a6d1b04](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/0a6d1b04a18677a1c3210a0f733f536eb927e223))
- **responsiveUI:**
  - use flex on header, position fix body viewport
  ([ff635ec6](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/ff635ec6882715cdf3ba3a6932f870ceeb427b73))
  - go with a less is more approach on mobile, add some spacing to tx-addrs on tablet sized resolutions
  ([d0621e31](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/d0621e3168cad0138be09f669de55c4682435c6f))
- **send:** to label displays correctly depending on the destinations
  ([c53ad049](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/c53ad049eb337e0f242257c29d2b1210e19dcb99))
- **transactions-feed:** watch the account index and fetch more tx's for that account, update test suite with mocked up MyWallet
  ([5ede55fa](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/5ede55fa3bf2d9879c94decf61abea2105a3044e))
- **upgrade:** Insist on 2nd password more clearly. Show spinner.
  ([8f0e7acb](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/8f0e7acb014477c6294535018b01140b0925108f))
- **verify-mobile-number:**
  - link for resending verification code
  ([4b9e8d14](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/4b9e8d14727339c0a585d0560d4d4ec86cc8e6bb))
  - reset verification code and error message on completion
  ([17e047fc](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/17e047fc1db68d9c3a18524fe23cb27f7d9f3eb1))


## Features

- **UI:** make wallet navigation on mobile take up entire height of screen, shift toggle menu to right hand side
  ([a6c369a0](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/a6c369a0f4a2174855db21bf9161142d5bcae64a))
- **browser:** drop support for Safari 3, 4 & 5
  ([97c26809](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/97c2680916b84735e461e9412eaefafa095c09f2))
- **ladda-spinner:** remove gif, use a pure CSS3 spinner instead
  ([ecabaad2](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/ecabaad2c0e71a738d00c0845ca49bc4137e4356))
- **signup:** remove email verification step
  ([32df37c9](https://github.com/blockchain/My-Wallet-HD-Frontend/commit/32df37c9f6fa7b115beba0489f6fa7dd2db8e058))


## Refactor

- delete unused navigation_ctrl methods
- **TopCtrl:** simplified reference to Wallet.total
- **UI:**
  - remove unused PNG's, delete unused CSS and references to it
  - normalize all settings UI to have labels if it's enable/disabled, remove references to old bootstrap buttons, deletes unused css
  - left align typography in receive modal & home page, reduce line-height
  - audit hex values and replace them with scss variable names, cleanup old css along the way
  - remove unused bootstrap references, add padding to textarea in send modal
  - align cols to baseline in home, less clunky first-time modal
  - update note ux, center modals, redo send confirm screen, update ladda spinner
- **signin:** move out of modals for sign up, get rid of registration ctrl & test
- **signup:**
  - more cleanup inside signup markup + css, rm reference to registration ctrl
  - move register html into signup, controller refactored, delete unused css


## Chore

- **changelog:**
  - add to grunt dist task
  - configured git-changelog



---
<sub><sup>*Generated with [git-changelog](https://github.com/rafinskipg/git-changelog). If you have any problem or suggestion, create an issue.* :) **Thanks** </sub></sup>