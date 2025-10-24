export function resolveAsset(path: string) {
    return new URL(path, import.meta.url).href
}