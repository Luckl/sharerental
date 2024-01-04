package nl.sharerental.be

import be.woutschoovaerts.mollie.data.common.AddressRequest
import be.woutschoovaerts.mollie.data.common.Amount
import be.woutschoovaerts.mollie.data.common.ApplicationFee
import be.woutschoovaerts.mollie.data.common.Locale
import be.woutschoovaerts.mollie.data.payment.PaymentMethod
import be.woutschoovaerts.mollie.data.payment.PaymentRequest
import be.woutschoovaerts.mollie.data.payment.SequenceType
import org.springframework.aot.hint.MemberCategory
import org.springframework.aot.hint.RuntimeHints
import org.springframework.aot.hint.RuntimeHintsRegistrar
import org.springframework.aot.hint.TypeReference
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
        hints.serialization().registerType(TypeReference.of(PaymentRequest::class.java))
        hints.serialization().registerType(TypeReference.of(Amount::class.java))
        hints.serialization().registerType(PaymentMethod::class.java)
        hints.serialization().registerType(Locale::class.java)
        hints.serialization().registerType(SequenceType::class.java)
        hints.serialization().registerType(TypeReference.of(AddressRequest::class.java))
        hints.serialization().registerType(TypeReference.of(ApplicationFee::class.java))
    }
}