const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'primary': {
          DEFAULT: '#9D6954',
          '50': '#E1CFC7',
          '100': '#DAC3BA',
          '200': '#CCAC9F',
          '300': '#BE9585',
          '400': '#AF7E6A',
          '500': '#9D6954',
          '600': '#785140',
          '700': '#54382D',
          '800': '#2F2019',
          '900': '#0B0706'
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
