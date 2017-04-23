const CONFIG = {
  dbCleanInterval: 1000 * 60 * 60,
  dbPath: './server/db/',
  floodServerPort: 3000,
  maxHistoryStates: 30,
  pollInterval: 1000 * 5,
  secret: '<flood_secret>',
  scgi: {
    host: '<rtorrent_host>',
    port: <rtorrent_port>,
    socket: <rtorrent_socket>,
    socketPath: '<rtorrent_socket_path>'
  },
  ssl: <flood_ssl>,
  sslKey: '<flood_ssl_key>',
  sslCert: '<flood_ssl_cert>'
};

module.exports = CONFIG;
