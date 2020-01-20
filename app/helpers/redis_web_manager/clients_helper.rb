# frozen_string_literal: true

module RedisWebManager
  module ClientsHelper
    def age(value)
      time_ago_in_words(Time.now - value.seconds).humanize
    end

    def flags(value)
      {
        A: 'Connection to be closed ASAP',
        b: 'Client is waiting in a blocking operation',
        c: 'Connection to be closed after writing entire reply',
        d: 'Watched keys has been modified - EXEC will fail',
        i: 'Client is waiting for a VM I/O (deprecated)',
        M: 'Client is a master',
        N: 'No specific flag set',
        O: 'Client is a client in MONITOR mode',
        P: 'Client is a Pub/Sub subscriber',
        r: 'Client is in readonly mode against a cluster node',
        S: 'Client is a replica node connection to this instance',
        u: 'Client is unblocked',
        U: 'Client is connected via a Unix domain socket',
        X: 'Client is in a MULTI/EXEC context'
      }[value.to_sym]
    end

    def events(value)
      {
        r: 'Readable',
        w: 'Writable'
      }[value.to_sym]
    end
  end
end
