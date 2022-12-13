module.exports = {
//"extends": [
//    "airbnb",
//    "airbnb/hooks",
//    "plugin:@typescript-eslint/recommended",
//    "plugin:prettier/recommended"
//  ],
"extends": ["airbnb", "prettier",],
  "plugins": ["prettier"],

// This line is required to fix "unexpected token" errors
        "rules": {
            "indent": ["warn", 4],
            "react/jsx-indent": ["warn", 4, { "checkAttributes": true}],
            "react/react-in-jsx-scope": "off",
            "react/destructuring-assignment": "off",
            "no-nested-ternary": "warn",
            "react/prop-types": "warn"
        },
  root: true,
  env: {
    es6: true,
    node: true,
  },


//  extends: [
//    "eslint:recommended",
//    "google",
//  ],
//  rules: {
//    quotes: ["error", "double"],
//  },

};


