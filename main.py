from wget_py.scraper import html_to_title, json_response


def lambda_handler(event, context):
    return (html_to_title(event['url']) if 'url' in event
            else json_response(error='Missing a required argument "url"'))
