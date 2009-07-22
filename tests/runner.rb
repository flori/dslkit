#!/usr/bin/env ruby

$:.unshift '../lib'
$:.unshift 'tests'

warn "Test polite."
fork { load 'test_polite.rb' }
Process.waitpid
warn "Test rude."
fork { load 'test_rude.rb' }
Process.waitpid
