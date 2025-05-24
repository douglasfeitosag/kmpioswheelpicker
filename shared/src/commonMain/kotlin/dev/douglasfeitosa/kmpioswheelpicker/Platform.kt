package dev.douglasfeitosa.kmpioswheelpicker

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform