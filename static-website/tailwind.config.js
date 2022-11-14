/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./components/**/*.{js,vue,ts}",
    "./layouts/**/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./nuxt.config.{js,ts}",
  ],
  theme: {
      fontFamily: {
        'sans': ['DM Sans'],
        'serif': ['DM Sans'],
        'mono': ['DM Mono'],
      },
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
