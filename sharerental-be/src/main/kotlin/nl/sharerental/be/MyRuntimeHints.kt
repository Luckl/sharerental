package nl.sharerental.be

import org.springframework.aot.hint.MemberCategory
import org.springframework.aot.hint.RuntimeHints
import org.springframework.aot.hint.RuntimeHintsRegistrar
import java.lang.management.LockInfo
import java.lang.management.MemoryUsage
import java.lang.management.MonitorInfo
import java.lang.management.ThreadInfo


class MyRuntimeHints : RuntimeHintsRegistrar {
    override fun registerHints(hints: RuntimeHints, classLoader: ClassLoader?) {
        hints.reflection().registerType(MemoryUsage::class.java, MemberCategory.INTROSPECT_PUBLIC_METHODS)
        hints.reflection().registerType(ThreadInfo::class.java, MemberCategory.INTROSPECT_PUBLIC_METHODS)
        hints.reflection().registerType(LockInfo::class.java, MemberCategory.INTROSPECT_PUBLIC_METHODS)
        hints.reflection().registerType(MonitorInfo::class.java, MemberCategory.INTROSPECT_PUBLIC_METHODS)
        hints.reflection().registerType(StackTraceElement::class.java, MemberCategory.INTROSPECT_PUBLIC_METHODS)
    }
}