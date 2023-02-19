local log = require "aszswaz.logger"

function test01()
    log.debug "debug\ndebugaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    log.info "info\ninfo"
    log.warn "warn"
    log.error "error"
    log.showMessages()
end
