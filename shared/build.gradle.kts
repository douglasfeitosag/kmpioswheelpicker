import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

group = "io.github.douglasfeitosag"
version = "1.0.0"
description = "A Kotlin Multiplatform native iOS Picker View"

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.kotlinCocoapods)
    id("org.jreleaser") version "1.8.0"
}

kotlin {
    cocoapods {
        summary = "iOS Wheel Picker for kotlin multiplatform"
        homepage = "https://github.com/douglasfeitosag/kmpioswheelpicker"
        version = "1.0.0"
        ios.deploymentTarget = "14.1"
        podfile = project.file("../iosApp/Podfile")
        framework {
            baseName = "shared"
            isStatic = true
        }
    }

    val xcf = XCFramework()
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            xcf.add(this)
            isStatic = true
        }

        it.compilations["main"].cinterops {
            val wheelPicker by creating {
                defFile(project.file("src/iosMain/cinterop/wheelPicker.def"))
                packageName("dev.douglasfeitosa.kmpioswheelpicker")
                includeDirs {
                    allHeaders(file("${rootProject.projectDir}/iosApp/KmpioswheelpickerFramework"))
                }
            }
        }
    }

    sourceSets {
        commonMain.dependencies {
            //put your multiplatform dependencies here
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
    }
}

jreleaser {
    project.description = "A Kotlin Multiplatform native iOS Picker View"
    project.copyright = "Copyright (c) 2025 Douglas Feitosa"
    gitRootSearch.set(true)
}