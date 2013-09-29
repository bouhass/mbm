import org.springframework.security.authentication.encoding.ShaPasswordEncoder

ShaPasswordEncoder passwordEncoder = new ShaPasswordEncoder(256)
println passwordEncoder.encodePassword('password', null)
