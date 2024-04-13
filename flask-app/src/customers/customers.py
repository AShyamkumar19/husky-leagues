from flask import Blueprint, current_app, request, jsonify, make_response
import json
from src import db


customers = Blueprint('customers', __name__)

# Get all customers from the DB
@customers.route('/customers', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('select id,  company, last_name,\
        first_name, job_title, business_phone from customers')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@customers.route('/customers/<userID>', methods=['GET'])
def get_customer(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from customers where id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@customers.route('/customers', methods=['PUT'])
def put_customer():
    data = request.json
    current_app.logger.info(data)

    userID = data['id']
    company = data['company']
    last_name = data['last_name']
    first_name = data['first_name']
    job_title = data['job_title']
    business_phone = data['business_phone']

    cursor = db.get_db().cursor()

    cursor.execute('''
        UPDATE customers 
        SET company = %s, last_name = %s, first_name = %s, job_title = %s, business_phone = %s 
        WHERE id = %s
    ''', (company, last_name, first_name, job_title, business_phone, userID))

    cursor = db.get_db().commit()

    return jsonify({'message': 'Customer information updated successfully'}), 200
