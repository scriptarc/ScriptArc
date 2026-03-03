/** @type {import('tailwindcss').Config} */
module.exports = {
    darkMode: ["class"],
    content: [
        "./src/**/*.{js,jsx,ts,tsx}",
        "./public/index.html"
    ],
    theme: {
        extend: {
            fontFamily: {
                outfit: ['Outfit', 'sans-serif'],
                manrope: ['Manrope', 'sans-serif'],
                mono: ['JetBrains Mono', 'monospace'],
            },
            colors: {
                background: 'hsl(var(--background))',
                foreground: 'hsl(var(--foreground))',
                surface: '#0A0A14',
                'surface-highlight': '#12121A',
                primary: {
                    DEFAULT: 'hsl(var(--primary))',
                    foreground: 'hsl(var(--primary-foreground))'
                },
                secondary: {
                    DEFAULT: 'hsl(var(--secondary))',
                    foreground: 'hsl(var(--secondary-foreground))'
                },
                accent: {
                    DEFAULT: 'hsl(var(--accent))',
                    foreground: 'hsl(var(--accent-foreground))'
                },
                warning: '#FF8C00',
                cyan: '#00C8FF',
                border: 'hsl(var(--border))',
                'text-primary': '#FFFFFF',
                'text-secondary': '#94A3B8',
                card: {
                    DEFAULT: 'hsl(var(--card))',
                    foreground: 'hsl(var(--card-foreground))'
                },
                popover: {
                    DEFAULT: 'hsl(var(--popover))',
                    foreground: 'hsl(var(--popover-foreground))'
                },
                muted: {
                    DEFAULT: 'hsl(var(--muted))',
                    foreground: 'hsl(var(--muted-foreground))'
                },
                destructive: {
                    DEFAULT: 'hsl(var(--destructive))',
                    foreground: 'hsl(var(--destructive-foreground))'
                },
                input: 'hsl(var(--input))',
                ring: 'hsl(var(--ring))',
            },
            borderRadius: {
                lg: '0.5rem',
                md: '0.375rem',
                sm: '0.25rem'
            },
            animation: {
                'accordion-down': 'accordion-down 0.2s ease-out',
                'accordion-up': 'accordion-up 0.2s ease-out',
                'first': 'moveVertical 30s ease infinite',
                'second': 'moveInCircle 20s linear infinite reverse',
                'third': 'moveInCircle 40s linear infinite',
                'fourth': 'moveHorizontal 35s ease infinite',
                'fifth': 'moveInCircle 25s ease infinite',
                'pulse-glow': 'pulse-glow 2s ease-in-out infinite',
                'float': 'float 3s ease-in-out infinite',
            },
            keyframes: {
                'accordion-down': {
                    from: { height: '0' },
                    to: { height: 'var(--radix-accordion-content-height)' }
                },
                'accordion-up': {
                    from: { height: 'var(--radix-accordion-content-height)' },
                    to: { height: '0' }
                },
                moveHorizontal: {
                    '0%': { transform: 'translateX(-40%) translateY(-10%)' },
                    '50%': { transform: 'translateX(40%) translateY(10%)' },
                    '100%': { transform: 'translateX(-40%) translateY(-10%)' },
                },
                moveInCircle: {
                    '0%': { transform: 'rotate(0deg)' },
                    '100%': { transform: 'rotate(360deg)' },
                },
                moveVertical: {
                    '0%': { transform: 'translateY(-40%)' },
                    '50%': { transform: 'translateY(40%)' },
                    '100%': { transform: 'translateY(-40%)' },
                },
                'pulse-glow': {
                    '0%, 100%': { opacity: '1', filter: 'drop-shadow(0 0 8px currentColor)' },
                    '50%': { opacity: '0.7', filter: 'drop-shadow(0 0 20px currentColor)' },
                },
                'float': {
                    '0%, 100%': { transform: 'translateY(0)' },
                    '50%': { transform: 'translateY(-10px)' },
                },
            },
            boxShadow: {
                'glow-primary': '0 0 20px rgba(0, 140, 255, 0.4)',
                'glow-accent': '0 0 20px rgba(0, 255, 180, 0.4)',
                'glow-secondary': '0 0 20px rgba(120, 0, 255, 0.4)',
            }
        }
    },
    plugins: [require("tailwindcss-animate")],
};
