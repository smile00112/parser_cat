################################################################################
@CLASS
mod_rewrite
################################################################################
@make_rewrite[]
^use[news_cms.p;$.replace(true)]
$result[^news_cms:GenerateHtaccessRules[]]
################################################################################