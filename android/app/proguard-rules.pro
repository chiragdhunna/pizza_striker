# Rules to handle missing ErrorProne and javax annotations
-dontwarn com.google.errorprone.annotations.*
-dontwarn javax.annotation.**
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.annotation.** { *; }
