fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Kz#5669 : Cart Managment'

dependencies {
	'qbr-core'
}

shared_scripts {
	'@qbr-core/shared/locale.lua',
    'locale/lang.lua',
	'config.lua'
}
client_scripts {
    'client/*.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

lua54 'yes'