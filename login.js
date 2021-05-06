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

Auth.signIn(process.argv[2], process.argv[3]).then(user => console.log(user.signInUserSession.accessToken.jwtToken)).catch(err => console.log(err))
