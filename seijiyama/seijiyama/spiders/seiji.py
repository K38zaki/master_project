import scrapy
from seijiyama.items import SeijiyamaItem
import pandas as pd


class SeijiSpider(scrapy.Spider):
    name = 'seiji'
    allowed_domains = ['seijiyama.jp/area/card/3718/eFI5fe/M?S=lctfq0pcph']
    start_urls = ['http://seijiyama.jp/area/card/3718/eFI5fe/M?S=lctfq0pcph']

    def parse(self, response):
        item = SeijiyamaItem()
        item['result'] = response.css('table::text').extract()
        return item
    
            #sp_list > div.personlist > form
        
