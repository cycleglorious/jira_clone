/**
 * Run `build` or `dev` with `SKIP_ENV_VALIDATION` to skip env validation.
 * This is especially useful for Docker builds.
 */
!process.env.SKIP_ENV_VALIDATION && (await import("./env.mjs"));
export const dynamic = 'force-dynamic'

/** @type {import("next").NextConfig} */
const config = {
  reactStrictMode: true,
  experimental: { appDir: true },
  output: "standalone",
  generateBuildId: async () => {
    // This could be anything, using the latest git hash
    return "build-id"
  },
  redirects: async () => {
    return [
      {
        source: "/project",
        destination: "/project/backlog",
        permanent: true,
      },
      {
        source: "/",
        destination: "/project/backlog",
        permanent: true,
      },
    ];
  },
  images: {
    domains: [
      "images.clerk.dev",
      "www.gravatar.com",
      "images.unsplash.com",
      "avatars.githubusercontent.com",
      "img.clerk.com",
    ],
  },
  /**
   * If you have the "experimental: { appDir: true }" setting enabled, then you
   * must comment the below `i18n` config out.
   *
   * @see https://github.com/vercel/next.js/issues/41980
   */
  // i18n: {
  //   locales: ["en"],
  //   defaultLocale: "en",
  // },
  eslint: {
    // Warning: This allows production builds to successfully complete even if
    // your project has ESLint errors.
    ignoreDuringBuilds: true,
  },
};
export default config;
