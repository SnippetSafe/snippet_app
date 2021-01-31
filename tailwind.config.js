
module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        cyan: {
          hover: '#51b9b4',
          light: '#DEF2F1',
          DEFAULT: '#3AAFA9'
        },
        'space-cadet': {
          DEFAULT: '#25283D'
        },
        'plum': {
          DEFAULT: '#8F3985'
        },
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms')
  ],
}
