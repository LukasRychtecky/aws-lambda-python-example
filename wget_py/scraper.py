from HTMLParser import HTMLParser

import requests


class SillyHTMLParser(HTMLParser):

    def __init__(self):
        HTMLParser.__init__(self)
        self.current_tag = None
        self.data = []

    def handle_starttag(self, tag, attrs):
        self.current_tag = tag

    def handle_data(self, data):
        if self.current_tag == 'title':
            self.data.append(data)

    @property
    def result(self):
        return ''.join(self.data).strip()


def json_response(error=None, title=None):
    return {
        'error': error,
        'title': title,
    }


def html_to_title(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            parser = SillyHTMLParser()
            parser.feed(response.content)
            return (json_response(error='Given website has no title element') if parser.data is None
                    else json_response(title=parser.result))
        else:
            return json_response(error='Given status code {}'.format(response.status_code))
    except requests.exceptions.ConnectionError as e:
        return json_response(error=str(e))
