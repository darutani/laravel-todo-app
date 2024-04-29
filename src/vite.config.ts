import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import react from '@vitejs/plugin-react';
import fs from 'fs';
import 'dotenv/config';

const host = `${process.env.PROJECT_NAME}.test` ?? 'localhost';

export default defineConfig({
    server: {
        host: host,
        hmr: {
            host
        },
        https: {
            key: fs.readFileSync(`/etc/vite/ssl/local-key.pem`),
            cert: fs.readFileSync(`/etc/vite/ssl/local-cert.pem`),
        }
    },
    plugins: [
        react(),
        laravel({
            input: [
                'resources/scss/app.scss',
                'resources/ts/index.tsx'
            ],
            refresh: true,
        }),
    ],
});
