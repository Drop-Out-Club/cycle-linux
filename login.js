import Amplify, { Auth } from 'aws-amplify'

require('dotenv').config()

Amplify.configure({
  Auth: {
    identityPoolId: process.env.IDENTITY_POOL_ID,
    userPoolId: process.env.USER_POOL_ID,
    userPoolWebClientId: process.env.COGNITO_CLIENT_ID,
    region: process.env.COGNITO_REGION
  }
})

if (process.argv[2] === '--login') {
  Auth.signIn(process.argv[3], process.argv[4]).then(user => console.log(user.signInUserSession.accessToken.jwtToken)).catch(err => console.log(err))
} else if (process.argv[2] === '--signup') {
  Auth.signUp({
    username: process.argv[3],
    password: process.argv[4],
    attributes: {
      email: process.argv[3],
      phone_number: process.argv[5]
    }
  }).catch(err => console.log(err))
} else if (process.argv[2] === '--confirm') {
  Auth.confirmSignUp(process.argv[3], process.argv[4]).catch(err => console.log(err))
}
