const images = import.meta.glob('./src/assets/images/*.(avif|jpeg|jpg|png|webp|gif)', {
  eager: true
})

export function imageUrl(path: string): string {
  const imagePath = './assets/images/' + path
  if (images[imagePath]) {
    return (images[imagePath] as any).default
  } else {
    console.warn(`Could not find image with path: ${path}`)
    return 'https://via.placeholder.com/150'
  }
}
